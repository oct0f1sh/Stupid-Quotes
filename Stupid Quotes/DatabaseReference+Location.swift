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
        case quotes(groupID: String)
        case groupMembers()
        case groupMembersOfID(groupID: String)
        case quote(groupID: String, quoteID: String)
        
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
            case .quotes(let groupID):
                return root.child("groups").child(groupID).child("quotes")
            case .groupMembersOfID(let groupID):
                return root.child("group_members").child(groupID)
            case .groupMembers():
                return root.child("group_members")
            case .quote(let quoteID, let groupID):
                return root.child("groups").child(groupID).child("quotes").child(quoteID)
            }
        }
    }
    
    static func toLocation(_ location: SQLocation) -> DatabaseReference {
        return location.asDatabaseReference()
    }
}
