//
//  MockProvider.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

class MockProvider {
    static let shared = MockProvider()
    private init() {}
    
    func makeUser() -> User {
        return User(name: "Muiz", token: "abc")
    }
}
