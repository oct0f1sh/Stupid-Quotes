//
//  File.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation

class Group {
    let groupID: String
    let usersInGroup: [User]
    
    init(groupID: String, usersInGroup: [User]) {
        self.groupID = groupID
        self.usersInGroup = usersInGroup
    }
}
