//
//  ViewController.swift
//  swift-app
//
//  Created by Hendrik Van Heuverswyn on 25/12/2017.
//  Copyright © 2017 Hendrik Van Heuverswyn. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //TODO
    }
}

