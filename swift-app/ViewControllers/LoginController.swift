//
//  ViewController.swift
//  swift-app
//
//  Created by Hendrik Van Heuverswyn on 25/12/2017.
//  Copyright © 2017 Hendrik Van Heuverswyn. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func login() {
        //TODO remove hardcoded entry
        emailTextField.text = "a@figlon.com"
        passwordTextField.text = "testerino"
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
        // skip navigation controller
        let destinationNavigationController = segue.destination as! UINavigationController
        let collectionViewController = destinationNavigationController.topViewController
        // do stuff
    }

    @IBAction func unwindLogout(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "logout" else {
            fatalError("Unknown segue")
        }
    }
    
    func resetFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        errorLabel.isHidden = true
    }
}

