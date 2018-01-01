import Foundation
import Firebase
import UIKit
import FirebaseDatabase

class AddDataTableViewController: UITableViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var hoogvogels: UITextField!
    @IBOutlet weak var zijvogels: UITextField!
    @IBOutlet weak var kalleVogels: UITextField!
    @IBOutlet weak var kleineVogels: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var ref:DatabaseReference!
    var sum: Int = 0
  
    override func viewDidLoad() {
        ref = Database.database().reference()
        hoogvogels.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        zijvogels.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        kalleVogels.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        kleineVogels.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    @IBAction func save() {
        // hide label for new series of checks
        errorLabel.isHidden = true
        sum = 0
        // check
        let hv = checkValue(rawInput: hoogvogels.text!)
        let zv = checkValue(rawInput: zijvogels.text!)
        let kv = checkValue(rawInput: kalleVogels.text!)
        let klv = checkValue(rawInput: kleineVogels.text!)
        // check if the label popped up
        if errorLabel.isHidden {
            //no error, save data
            if sum > 75{
                // nobody shoots this many. Experienced archers only reach about 20-30
                showError("Geen realistisch waarde (>75)")
            } else{
                // send data
                let name = UserSupport.getCurrentUser()
                let timestamp = Date().ticks
                self.ref.child("statistics").child(name).child(String(timestamp))
                    .setValue([
                        "hoogvogels": hv,
                        "zijvogels": zv,
                        "kalleVogels": kv,
                        "kleineVogels": klv
                        ])
                performSegue(withIdentifier: "didAddData", sender: self)
            }
        }
    }
    
    func checkValue(rawInput: String) -> Int{
        // trim the string
        let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
        // check input
        if Int(input) == nil{
            showError("Enkel numerieke waarden")
            return 0
        } else{
            sum += Int(input)!
            return Int(input)!
        }
    }
    
    // based on https://stackoverflow.com/questions/34941069/enable-a-button-in-swift-only-if-all-text-fields-have-been-filled-out
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        // check if all fields have content
        guard
            let hv = hoogvogels.text, !hv.isEmpty,
            let zv = zijvogels.text, !zv.isEmpty,
            let kv = kalleVogels.text, !kv.isEmpty,
            let klv = kleineVogels.text, !klv.isEmpty
            else {
                saveButton.isEnabled = false
                return
        }
        saveButton.isEnabled = true
    }
    
    func showError(_ error: String){
        errorLabel.text = error
        errorLabel.isHidden = false
    }
}

// source https://stackoverflow.com/questions/39829831/how-to-get-18-digit-current-timestamp-in-swift
// used to get a unique timestamp
extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
