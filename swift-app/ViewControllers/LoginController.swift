import UIKit
import Firebase

class LoginController: UIViewController {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login() {
        // Using firebase authentication
        // Source: https://firebase.google.com/docs/auth/
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            if ( email.isEmpty || password.isEmpty ) {
                errorLabel.text = "Vul alle velden in"
                errorLabel.isHidden = false
            } else{
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if error != nil {
                        self.errorLabel.text = "Ongeldige login"
                        self.errorLabel.isHidden = false
                    } else {
                        self.performSegue(withIdentifier: "showOptions", sender: self)
                        // success - reset fields
                        self.resetFields()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showOptions" else {
            fatalError("Unknown segue")
        }
    }

    @IBAction func unwindLogout(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "logout" else {
            fatalError("Unknown segue")
        }
        do {
            try Auth.auth().signOut()
        } catch {
            fatalError("Signing out failed")
        }
        
    }
    
    func resetFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        errorLabel.isHidden = true
    }
}

