//
//  UserService.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/8/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Firebase

struct UserService {
    static func getUser(uid: String, completion: @escaping (User?) -> Void) {
        let ref = DatabaseReference.toLocation(.user(uid: uid))
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String:Any]
                else { return completion(nil) }
            
            let uid = snapshot["uid"] as! String
            let username = snapshot["username"] as! String
            let email = snapshot["email"] as! String
            
            let capturedUser = User(uid: uid, username: username, email: email)
            
            completion(capturedUser)
        })
    }
    
    static func getUserWithUsername(username: String, completion: @escaping (User?) -> Void) {
        let ref = DatabaseReference.toLocation(.users)
        
        let dGroup = DispatchGroup()
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion(nil) }
            
            for user in snapshot {
                dGroup.enter()
                if user.childSnapshot(forPath: "username").value as? String == username {
                    let createdUser = User(snapshot: user)
                    dGroup.leave()
                    return completion(createdUser)
                } else {
                    dGroup.leave()
                }
                completion(nil)
            }
        })
    }
    
    static func getUserGroups(uid: String, completion: @escaping ([Group]?) -> Void) {
        let ref = DatabaseReference.toLocation(.groupMembers())
        
        var groups = [Group]()
        
        let dGroup = DispatchGroup()
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion(nil) }
            
            for group in snapshot {
                dGroup.enter()
                if group.hasChild(uid) {
                    GroupService.getGroup(groupID: group.key) { (group) in
                        if let group = group {
                            groups.append(group)
                            dGroup.leave()
                        }
                    }
                } else { dGroup.leave() }
            }
            
            dGroup.notify(queue: .main, execute: {
                print("number of groups: \(groups.count)")
                completion(groups)
            })
        })
    }
}
