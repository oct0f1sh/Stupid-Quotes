//
//  FriendsViewController.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/13/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class FriendsViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        self.backgroundView.roundCorners([.topLeft, .topRight], radius: Style.roundedCorner)
    }
}


