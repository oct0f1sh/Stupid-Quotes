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
            guard let snapshot = snapshot.value as? DataSnapshot
                else { return completion(nil) }
            
            guard let capturedUser = User(snapshot: snapshot)
                else { return completion(nil) }
            
            completion(capturedUser)
        })
    }
}
