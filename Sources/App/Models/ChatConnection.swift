import Vapor
import Foundation

internal struct ChatConnection
{
    internal var nick: String
    internal var room: String
    internal var webSocket: WebSocket
}