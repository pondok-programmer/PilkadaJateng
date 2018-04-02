//
//  TipsService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/31/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

class WacanaService {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getData(url: String, completion: @escaping ([MateriWacana]?, Error?) -> ()) {
        let url = networkManager.url(for: url)!
        networkManager.get(from: url) { (json, error) in
            if let json = json {
                let materiWacana = json["materi_wacana"].array.or([])
                    .map({ MateriWacana($0) })
                
                completion(materiWacana, nil)
            }
            
            if let error = error {
                completion(nil, error)
            }
        }
    }
}
