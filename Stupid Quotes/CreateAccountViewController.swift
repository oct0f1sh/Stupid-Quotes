//
//  SignUpViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController, ToSignUpDelegate {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    func passUserInfo(username: String, password: String) {
        print("neato")
        self.usernameTextField.text = username
        self.passwordTextField.text = password
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUpSegue" {
            let loginViewController = segue.destination as! LoginViewController
            loginViewController.delegate = self
        }
    }
}
