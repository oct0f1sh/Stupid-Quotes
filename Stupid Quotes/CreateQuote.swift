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
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBAction func unwindToCreateQuote(segue: UIStoryboardSegue) {
    }
    
    @IBAction func publishButtonTapped(_ sender: Any) {
        UserService.getUserGroups(uid: User.current.uid) { (groups) in
            if let groups = groups {
                let group = groups[0]
                
                QuoteService.createQuote(quote: self.quoteTextView.text, user: User.current, subject: self.subjectTextField.text!, groupID: group.groupID)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.usernameLabel.text = User.current.username
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        self.confirmAlert(title: "Log out?", message: "Are you sure you want to log out?", completion: { (confirmed) in
            if confirmed {
                do {
                    try Auth.auth().signOut()
                } catch let signOutError as NSError {
                    self.showAlert(title: "Error", message: signOutError.localizedDescription, actionText: "Ok")
                }
                self.performSegue(withIdentifier: "logInSegue", sender: self)
            }
        })
    }
    
    @IBAction func friendsButtonTapped(_ sender: Any) {
        
    }
}

