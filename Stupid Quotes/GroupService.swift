//
//  GroupService.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/9/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct GroupService {
    static func getGroup(groupID: String, completion: @escaping (Group?) -> Void) {
        let ref = DatabaseReference.toLocation(.group(groupID: groupID))
        
        getUsersInGroup(groupID: groupID, completion: { (groupUsers) in
            if let groupUsers = groupUsers {
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let snapshot = snapshot.value as? [String:Any]
                        else { return completion(nil) }
                    
                    let groupName = snapshot["group_name"] as! String
                    let groupCreatorUID = snapshot["creator_uid"] as! String
                    
                    let group = Group(groupID: groupID, groupName: groupName, usersInGroup: groupUsers, groupCreatorUID: groupCreatorUID)
                    
                    print("\(groupUsers.count) users in group")
                    return completion(group)
                })
            }
        })
    }
    
    static func getUsersInGroup(groupID: String, completion: @escaping ([User]?) -> Void) {
        let memRef = DatabaseReference.toLocation(.groupMembersOfID(groupID: groupID))
        
        var groupUsers = [User]()
        
        memRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String:Any]
                else { return completion(nil) }
            
            let dGroup = DispatchGroup()
            
            for user in snapshot {
                dGroup.enter()
                UserService.getUser(uid: user.key, completion: { (user) in
                    if let user = user {
                        print("adding \(user.username) to group")
                        groupUsers.append(user)
                        dGroup.leave()
                    }
                })
            }
            
            dGroup.notify(queue: .main, execute: {
                print("completion")
                completion(groupUsers)
            })
        })
    }
    
    static func newGroup(user: User, groupName: String, completion: @escaping (String?) -> Void) {
        let ref = DatabaseReference.toLocation(.groups)
        
        let key = ref.childByAutoId().key
    
        let memRef = DatabaseReference.toLocation(.groupMembersOfID(groupID: key))
        
        let groupDict: [String:Any] = ["creator_uid" : user.uid,
                                       "group_name" : groupName]
        
        ref.child(key).setValue(groupDict)
        
        memRef.setValue([user.uid:user.username])
        
        return completion(key)
    }
}
