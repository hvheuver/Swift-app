import Foundation
import Firebase
import UIKit
import FirebaseDatabase

class AddDataTableViewController: UITableViewController {
    @IBOutlet weak var hoogvogels: UITextField!
    @IBOutlet weak var zijvogels: UITextField!
    @IBOutlet weak var kalleVogels: UITextField!
    @IBOutlet weak var kleineVogels: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func save() {
        //TODO
    }
    
    func checkValue(rawInput: String) {
        // trim the string
        let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
        // check input
        if input.isEmpty {
            errorLabel.text = "Velden verplicht"
            errorLabel.isHidden = false
        } else{
            if Int(input) == nil{
                errorLabel.text = "Enkel numerieke waarden"
                errorLabel.isHidden = false
            }
        }
       
    }
}
