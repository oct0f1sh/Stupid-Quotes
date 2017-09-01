//
//  LoginViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var inputBackgroundView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func unwindToLogin(sender: UIStoryboardSegue) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.inputBackgroundView.roundCorners([.allCorners], radius: Style.roundedCorner)
        self.loginButton.layer.cornerRadius = Style.borderRadius
        self.signupButton.layer.cornerRadius = Style.borderRadius
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if usernameTextField.text != nil && usernameTextField.text != "" {
            if passwordTextField.text != nil && passwordTextField.text != "" {
                LoginService.handleUser(username: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                        self.showAlert(title: "Error", message: error.localizedDescription, actionText: "Ok")
                        return
                    } else if error == nil {
                        if let user = user {
                            self.performSegue(withIdentifier: "logInSegue", sender: self)
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
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
}
