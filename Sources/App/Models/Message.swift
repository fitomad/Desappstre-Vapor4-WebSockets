
import Foundation

internal struct Message: Codable
{

    internal enum Kind: String, Codable
    {
        case `public`
        case `private`
    }

    internal private(set) var text: String
    internal private(set) var senderNick: String
    internal private(set) var destinationRoom: String
    internal private(set) var kind: Message.Kind

    private enum CodingKeys: String, CodingKey
    {
        case text
        case senderNick = "sender"
        case destinationRoom = "room"
        case kind = "message_type"
    }
}