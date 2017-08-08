//
//  ViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit
import Firebase

class CreateQuote: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var quoteTextField: UITextField!
    
    @IBAction func publishButtonTapped(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.usernameLabel.text = User.current.username
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logInSegue", sender: self)
        } catch let signOutError as NSError {
            self.showAlert(title: "Error", message: signOutError.localizedDescription, actionText: "Ok")
        }
    }
}

