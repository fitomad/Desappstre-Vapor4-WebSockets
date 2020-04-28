
import Foundation

internal struct LoginRequest: Codable
{
    ///
    internal private(set) var nickname: String
    ///
    internal private(set) var roomName: String

    ///
    private enum CodingKeys: String, CodingKey
    {
        case nickname
        case roomName = "room"
    }
}