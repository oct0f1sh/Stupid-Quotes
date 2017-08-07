//
//  LoginViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

protocol ToSignUpDelegate {
    func passUserInfo(username: String, password: String)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var inputBackgroundView: UIView!
    
    var delegate: ToSignUpDelegate? = nil
    
    override func viewDidLoad() {
        self.inputBackgroundView.layer.cornerRadius = Style.borderRadius
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if usernameTextField.text != nil && usernameTextField.text != "" {
            if passwordTextField.text != nil && passwordTextField.text != "" {
                LoginService.handleUser(username: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if let error = error {
                        self.showAlert(title: "Error", message: error, actionText: "OK")
                    } else {
                        if let user = user {
                            User.setCurrent(user)
                        }
                    }
                }
            } else {
                self.showAlert(title: "Blank Password", message: "Please enter a password", actionText: "Ok")
            }
        } else {
            self.showAlert(title: "Blank Username", message: "Please enter a username", actionText: "Ok")
        }
    }
}
