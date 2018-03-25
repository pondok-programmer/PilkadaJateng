//
//  InformasiCalonService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

class InformasiCalonService {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
//    func getData(completion: @escaping (String?, Error?) -> ()) {
//        let url = networkManager.url(for: APIUtils.profileCalon)!
//        networkManager.get(from: url) { (str, error) in
//            completion(str, error)
//        }
//    }
}
