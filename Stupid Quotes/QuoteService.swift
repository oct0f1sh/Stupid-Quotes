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
    static func createQuote(quote: String, user: User, subject: String, groupID: String) {
        let ref = DatabaseReference.toLocation(.group(groupID: groupID))
        
        let key = ref.childByAutoId().key
        
        let quoteDict: [String:Any] = ["quote" : quote,
                                       "author" : user.username,
                                       "subject" : subject,
                                       "quote_id" : key]
        
        ref.child("quotes").child(key).setValue(quoteDict)
        
        print("Published quote")
        
        return
    }
    
    static func deleteQuote(quote: Quote, group: Group, completion: @escaping () -> Void) {
        let ref = DatabaseReference.toLocation(.quote(groupID: group.groupID, quoteID: quote.quoteID))
        
        ref.removeValue()
        print("quote deleted")
        
        completion()
    }
    
    static func getQuotes(groupID: String, completion: @escaping ([Quote]?) -> Void) {
        let ref = DatabaseReference.toLocation(.quotes(groupID: groupID))
        
        var quotes = [Quote]()
        
        let dispatchGroup = DispatchGroup()
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            for quote in snapshot {
                dispatchGroup.enter()
                print(quote)
                let capturedQuote = Quote(snapshot: quote)
                quotes.append(capturedQuote!)
                dispatchGroup.leave()
            }
            
            return completion(quotes)
        })
    }
}
