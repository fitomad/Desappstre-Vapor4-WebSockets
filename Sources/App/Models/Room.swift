import Vapor
import Foundation

internal struct Room: Codable
{
    ///
    internal private(set) var name: String
    ///
    internal private(set) var topic: String?

    ///
    private enum CodingKeys: String, CodingKey
    {
        case name
        case topic
    }

    internal init(named name: String, topic: String?)
    {
        self.name = name
        self.topic = topic
    }
}