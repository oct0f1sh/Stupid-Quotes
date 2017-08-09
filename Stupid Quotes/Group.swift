//
//  File.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Firebase

class Group {
    let groupID: String
    let groupName: String
    let usersInGroup: [User]
    let groupCreatorUID: String
    
    init(groupID: String, groupName: String, usersInGroup: [User], groupCreatorUID: String) {
        self.groupID = groupID
        self.groupName = groupName
        self.usersInGroup = usersInGroup
        self.groupCreatorUID = groupCreatorUID
    }
}
