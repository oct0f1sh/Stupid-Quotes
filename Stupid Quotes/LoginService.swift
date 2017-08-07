//
//  LoginService.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import Firebase

typealias FIRUser = FirebaseAuth.User

class LoginService {
    static func handleUser(username: String, password: String, completion: @escaping (User?, String?) -> Void) {
        doesUserExist(username: username) { (doesExist) in
            if doesExist {
                return completion(nil, "Username already exists")
            } else {
                let email = username + "@gmail.com"
                createUser(username: username, password: password, email: email) { (user) in
                    completion(user, nil)
                }
            }
        }
    }
    
    static func createUser(username: String, password: String, email: String, completion: @escaping (User) -> Void) {
        let ref = DatabaseReference.toLocation(.users)
        
        let uid = ref.childByAutoId().key
        
        let userDict: [String:Any] = ["username" : username,
                                      "uid" : uid]
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error == nil {
                print("Registered")
                ref.child(uid).setValue(userDict)
            } else {
                print("Error registering: \(String(describing: error))")
            }
        })
        
        let user = User(uid: uid, username: username)
        completion(user)
    }
    
    static func doesUserExist(username: String, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        let ref = DatabaseReference.toLocation(.users)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion(false) }
            
            for userSnap in snapshot {
                dispatchGroup.enter()
                
                let user = User(snapshot: userSnap)
                
                if user?.username == username {
                    dispatchGroup.leave()
                    return completion(true)
                } else {
                    dispatchGroup.leave()
                }
            }
            
            if snapshot.count == 0 {
                return completion(false)
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                return completion(false)
            })
        })
    }
}
