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
    static func handleUser(username: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        doesUserExist(username: username) { (user) in
            if let user = user {
                Auth.auth().signIn(withEmail: user.email, password: password) { (other, error) in
                    if error != nil {
                        return completion(nil, error)
                    } else {
                        return completion(user, nil)
                    }
                }
            } else {
                let noUser = NSError(domain: "Login", code: 69, userInfo: [NSLocalizedDescriptionKey : "User does not exist"])
                return completion(nil, noUser)
            }
        }
    }
    
    static func createUser(username: String, password: String, email: String, completion: @escaping (User?, Error?) -> Void) {
        let ref = DatabaseReference.toLocation(.users)
        
        let uid = ref.childByAutoId().key
        
        let userDict: [String:Any] = ["username" : username,
                                      "uid" : uid,
                                      "email" : email]
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error == nil {
                print("Registered")
                ref.child(uid).setValue(userDict)
                let user = User(uid: uid, username: username, email: email)
                completion(user, nil)
            } else {
                completion(nil, error)
            }
        })
    }
    
    static func doesUserExist(username: String, completion: @escaping (User?) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        let ref = DatabaseReference.toLocation(.users)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion(nil) }
            
            for userSnap in snapshot {
                dispatchGroup.enter()
                
                let user = User(snapshot: userSnap)
                
                if user?.username == username {
                    dispatchGroup.leave()
                    return completion(user)
                } else {
                    dispatchGroup.leave()
                }
            }
            
            if snapshot.count == 0 {
                return completion(nil)
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                return completion(nil)
            })
        })
    }
}
