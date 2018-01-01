import Foundation
import Firebase

class UserSupport {
    /**
     There's currently no real profile support in this app, since it's email/password based.
     Currently all users (also in our Willem Tell production db) users are registered under <name>@domain.be
     This class converts the Firebase Auth to practical data which can be used.
     */
    static func getCurrentUser() -> String{
        // Firebase does not support special characters as keys, such as ".", "@" ...
        // trim the email to get a username. Usernames are unique.
        var email = Auth.auth().currentUser!.email!
        // get the range from @, delete everything behind it
        if let range = email.range(of: "@") {
            // Use ..< to make a range that omits its upper value
            // - The Swift programming Language
            email.removeSubrange(range.lowerBound ..< email.endIndex)
        }
        return email
    }
}
