//
//  MockProvider.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

class MockProvider {
    static let shared = MockProvider()
    private init() {}
    
    func makeUser() -> User {
        return User(name: "Muiz", token: "abc")
    }
    
    func makePartisipasiNetworkMock() -> NetworkManager {
        return MOCKPartisipasiNetworkManager()
    }
    
    func makeAnggaranNetworkMock() -> NetworkManager {
        return MOCKAnggaranNetworkManager()
    }
}

fileprivate func resource(name: String, ofType type: String) -> Data? {
    if let path = Bundle.main.path(forResource: name, ofType: type) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            return data
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    } else {
        print("Invalid filename/path.")
        return nil
    }
}

class MOCKPartisipasiNetworkManager: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "partisipasi_pilkada", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}

class MOCKAnggaranNetworkManager: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "anggaran_pilkada", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}


