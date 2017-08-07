//
//  User.swift
//  Stupid Quotes
//
//  Created by Duncan MacDonald on 8/7/17.
//  Copyright © 2017 MakeSchool. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
import Firebase

class User: NSObject {
    let uid: String
    let username: String
    let email: String
    
    init(uid: String, username: String, email: String) {
        self.uid = uid
        self.username = username
        self.email = email
    }
    
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        return currentUser
    }
    
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            UserDefaults.standard.set(data, forKey: Constants.userDefaults.currentUser)
        }
        _current = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.userDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.userDefaults.username) as? String,
            let email = aDecoder.decodeObject(forKey: Constants.userDefaults.email) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        self.email = email
        
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let username = dict["username"] as? String,
            let uid = dict["uid"] as? String,
            let email = dict["email"] as? String
        else { return nil }
        
        self.username = username
        self.uid = uid
        self.email = email
        
        super.init()
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.userDefaults.uid)
        aCoder.encode(username, forKey: Constants.userDefaults.username)
        aCoder.encode(email, forKey: Constants.userDefaults.email)
    }
}
