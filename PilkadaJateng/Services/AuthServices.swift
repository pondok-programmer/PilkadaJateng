//
//  Service.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
// FIREBASE LOGIN

class AuthService {
    init() {}
    
    func login(username: String, password: String, completion: @escaping (User?, Error?)->() ) {
        let user = MockProvider.shared.makeUser()
        completion(user, nil)
    }
}
