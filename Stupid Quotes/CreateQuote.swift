//
//  ViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import UIKit

class CreateQuote: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var quoteTextField: UITextField!
    
    var user = User(uid: "0", username: "userZero")
    
    @IBAction func publishButtonTapped(_ sender: Any) {
        
        QuoteService.createQuote(quote: self.quoteTextField.text!, user: user, groupID: "0")
        
    }
}

