//
//  Service.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    init() {}
    
    func login(username: String, password: String, completion: @escaping (User?, Error?)->() ) {
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            if let id = user?.uid, let name = user?.displayName {
                let user = User(id: id, name: name )
                completion(user, nil)
            }
            
            if let error = error {
                completion(nil, error)
            }
        }
    }
    
    func createUser(displayName: String, username: String, password: String, completion: @escaping (User?, Error?) -> ()) {
        Auth.auth().createUser(withEmail: username, password: password) { (user, error) in
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { (changeError) in
                    if let changeError = changeError {
                        completion(nil, changeError)
                    } else {
                        completion(User(id: user.uid, name: user.displayName!), nil)
                    }
                }
            }
            
            if let error = error {
                completion(nil, error)
            }
        }
    }
}
