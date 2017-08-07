//
//  Quote.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation

class Quote {
    let quote: String
    let poster: User
    
    init(quote: String, poster: User) {
        self.quote = quote
        self.poster = poster
    }
}
