//
//  BeritaPilkadaService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

fileprivate let beritaAPI = "http://g.com"

class BeritaPilkadaService {
    private let _networkManager: NetworkManager
    init(_ networkManager: NetworkManager) {
        _networkManager = networkManager
    }
    
    func load(url: String,
              params: [String: String] = [:],
              completion: @escaping (BeritaItemList?, Error?) -> Void ) {
        let url = _networkManager.url(for: beritaAPI )!
        _networkManager.get(from: url ) { (json, error) in
            if let json = json {
                completion(BeritaItemList(json), nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
