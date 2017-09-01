//
//  SignUpViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        if usernameTextField.text != "" {
            if emailTextField.text != "" {
                if passwordTextField.text != "" && passwordTextField.text == confirmPasswordTextField.text {
                    LoginService.doesUserExist(username: usernameTextField.text!) { (exists) in
                        if (exists != nil) {
                            self.showAlert(title: "Error", message: "Username already in use", actionText: "Ok")
                        } else {
                            LoginService.createUser(username: self.usernameTextField.text!, password: self.passwordTextField.text!, email: self.emailTextField.text!) { (user, error) in
                                if let error = error {
                                    self.showAlert(title: "Error", message: error.localizedDescription, actionText: "Ok")
                                    return
                                } else {
                                    if let user = user {
                                        User.setCurrent(user, writeToUserDefaults: true)
                                        self.performSegue(withIdentifier: "toHome", sender: self)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    self.showAlert(title: "Password Error", message: "Please enter a password. Both password fields must be identical", actionText: "Ok")
                }
            } else {
                self.showAlert(title: "Blank Email", message: "Please enter a valid email address", actionText: "Ok")
            }
        } else {
            self.showAlert(title: "Blank Username", message: "Please enter a username", actionText: "Ok")
        }
    }
    
    override func viewDidLoad() {
        self.backgroundView.roundCorners([.allCorners], radius: Style.roundedCorner)
        self.createAccountButton.layer.cornerRadius = Style.borderRadius
    }
}
