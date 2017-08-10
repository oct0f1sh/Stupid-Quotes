//
//  Quote.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Firebase

class Quote {
    let quote: String
    let subject: String
    let author: String
    let quoteID: String
    
    init(quote: String, author: String, subject: String, quoteID: String) {
        self.quote = quote
        self.author = author
        self.subject = subject
        self.quoteID = quoteID
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let quote = dict["quote"] as? String,
            let author = dict["author"] as? String,
            let subject = dict["subject"] as? String,
            let quoteID = dict["quote_id"] as? String
            else { return nil }
        
        self.quote = quote
        self.author = author
        self.subject = subject
        self.quoteID = quoteID
    }
}
