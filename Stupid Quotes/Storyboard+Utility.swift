//
//  Storyboard+Utility.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/8/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum MType: String {
        case createquote
        case createaccount
        case login
        case groups
        
        var filename: String {
            if rawValue == "createquote" {
                return "CreateQuote"
            } else if rawValue == "createaccount" {
                return "CreateAccount"
            } else {
                return rawValue.capitalized
            }
        }
    }
    
    convenience init(type: MType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
