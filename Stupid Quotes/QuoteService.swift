//
//  QuoteService.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct QuoteService {
    static func createQuote(quote: String, user: User, groupID: String) {
        let ref = DatabaseReference.toLocation(.group(groupID: groupID))
        
        let quoteDict: [String:Any] = ["quote" : quote,
                                       "user" : user]
        
        ref.child("quotes").childByAutoId().setValue(quoteDict)
        
        return
    }
}
