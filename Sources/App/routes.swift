import Vapor
import Foundation

// MARK: - HTTP -

func routes(_ app: Application) throws {
    /// 
    app.get { req in
        return "It works!"
    }

    ///
    app.get("rooms") { req -> String in 
        DataManager.shared.rooms.map({ $0.name }).joined(separator: "<br />")
    }

    app.get("rooms", ":name") { req -> String in 
        if let roomName = req.parameters.get("name")
        {
            let users = DataManager.shared.connections.filter({ $0.room == roomName }).map({ $0.nick })
            return users.joined(separator: "\r\n")
        }
        else
        {
            return "No existe esa sala"
        }
    }

    ///
    app.post("login") { req -> HTTPStatus  in
        let login = try req.content.decode(LoginRequest.self)
        
        let controller = LoginController()

        if controller.existsUser(login.nickname) 
        {
            return .found
        }
        else
        {
            controller.manageRoom(login.roomName)
            req.session.data["nickname"] = login.nickname
            req.session.data["room"] = login.roomName
        }

        return .ok
    }
}

// MARK: - WebSockets -

func webSockets(_ app: Application) throws 
{
    app.webSocket("chat") { request, ws in 
        let controller = ChatController()

        //El usuario conecta mediante WebSockets.
        let userName = request.session.data["nickname"] ?? "Usuario desconocido"
        let room = request.session.data["room"] ?? "The Empty"

        controller.addUser(userName, in: room, withConnection: ws)

        print("👋 \(userName). Bienevenido a \(room)")

        // String enviado por el cliente
        ws.onText { ws, texto in
            let jsonDecoder = JSONDecoder()

            if let data = texto.data(using: .utf8), let publicMessage = try? jsonDecoder.decode(Message.self, from: data)
            {
                print("[\(room)] \(publicMessage.senderNick) > \(publicMessage.text)")
                controller.broadcast(message: publicMessage.text, from: userName, to: room)
            }
        }

        // `Data` enviado por el cliente
        ws.onBinary { ws, data in
            // [UInt8] received by this WebSocket.
            print("# \(data)")
        }

        // El usuario ha cerrado la sesión.
        // Basta con cerrar la pestaña del navegador 
        // para cerrar la sesión de WebSockets.
        ws.onClose.whenComplete { result in
            // Succeeded or failed to close.
            print("💀 [\(room)] \(userName)")
            controller.removeUser(userName, in: room)
        }
    }
}
