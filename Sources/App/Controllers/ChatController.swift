import Vapor
import Foundation

internal class ChatController
{
    /**

    */
    internal func addUser(_ nickname: String, in room: String, withConnection webSocket: WebSocket) -> Void
    {
        DataManager.shared.appendUser(nickname, to: room, usingConnection: webSocket)
    }

    /**

    */
    internal func removeUser(_ nickName: String, in room: String) -> Void
    {
        DataManager.shared.removeUser(nickName, in: room)
    }

    /**

    */
    internal func broadcast(message: String, from nickname: String, to roomName: String) -> Void
    {
        guard let connections = DataManager.shared.fetchConnections(forRoom: roomName) else
        {
            return 
        }

        let message = Message(text: message, senderNick: nickname, destinationRoom: roomName, kind: .public)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let data = try? encoder.encode(message), let jsonDocument = String(data: data, encoding: .utf8)
        {
            connections.forEach({ $0.webSocket.send(jsonDocument) })
        }
    }
}