
import Vapor
import Foundation

internal class DataManager
{
    ///
    internal static let shared = DataManager()

    ///
    internal private(set) var users: [User]
    ///
    internal private(set) var rooms: [Room]
    ///
    internal private(set) var connections: [ChatConnection]


    private init()
    {
        self.users = [User]()
        self.rooms = [Room]()
        self.connections = [ChatConnection]()
    }

    internal func fetchRoom(_ roomName: String) -> Room?
    {
        return self.rooms.filter({ $0.name == roomName }).first
    }

    internal func fetchConnections(forRoom name: String) -> [ChatConnection]?
    {
        return self.connections.filter({ $0.room == name })
    }

    internal func containsUser(_ nickname: String) -> Bool
    {
        return self.users.filter({ $0.nick == nickname }).count > 0
    }

    internal func insertUser(_ newUser: User) -> Void
    {
        self.users.append(newUser)
    }

    internal func containsRoom(_ name: String) -> Bool
    {
        return self.rooms.filter({ $0.name == name }).count > 0
    }

    internal func insertRoom(_ name: String) -> Void
    {
        let newRoom = Room(named: name, topic: nil)
        self.rooms.append(newRoom)
    }

    /**

    */
    internal func appendUser(_ nickname: String, to roomName: String, usingConnection webSocket: WebSocket) -> Void
    {
        let connection = ChatConnection(nick: nickname, room: roomName, webSocket: webSocket)
        self.connections.append(connection)
    }

    internal func removeUser(_ nickname: String, in roomName: String) -> Void
    {
        
    }
}