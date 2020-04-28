import Foundation

internal class LoginController
{
    /**

    */
    internal func existsUser(_ nickname: String) -> Bool
    {
        return DataManager.shared.containsUser(nickname)
    }

    /**

    */
    internal func registerUser(_ nickname: String) -> Void
    {
        let chatUser = User(nick: nickname, loginAt: Date())

        DataManager.shared.insertUser(chatUser)
    }

    /**

    */
    internal func manageRoom(_ name: String) -> Void
    {
        if !DataManager.shared.containsRoom(name)
        {
            DataManager.shared.insertRoom(name)
        }
    }
}