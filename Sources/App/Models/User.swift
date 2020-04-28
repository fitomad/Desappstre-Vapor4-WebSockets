
import Foundation

internal struct User: Codable
{
    internal private(set) var nick: String
    internal private(set) var loginAt: Date

    ///
    private enum CodingKeys: String, CodingKey
    {
        case nick = "nickname"
        case loginAt = "login_time"
    }
}