//
//  DatabaseReference+Location.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    enum SQLocation {
        case root
        case groups
        case users
        case group(groupID: String)
        case user(uid: String)
        
        func asDatabaseReference() -> DatabaseReference {
            let root = Database.database().reference()
            
            switch self {
            case .root:
                return root
            case .groups:
                return root.child("groups")
            case .users:
                return root.child("users")
            case .group(let groupID):
                return root.child("groups").child(groupID)
            case .user(let uid):
                return root.child("users").child(uid)
            }
        }
    }
    
    static func toLocation(_ location: SQLocation) -> DatabaseReference {
        return location.asDatabaseReference()
    }
}
