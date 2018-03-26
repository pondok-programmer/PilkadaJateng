//
//  InformasiPilkadaService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

enum InformasiPilkadaType {
    case tahapan
    case partisipasi
    case anggaran
    
    func getUrl() -> String {
        switch self {
        case .partisipasi: return APIUtils.partisipasiPilkada
        case .anggaran: return APIUtils.anggaranPilkada
        case .tahapan: return APIUtils.tahapanPilkada
        }
    }
}

class InformasiPilkadaService<T: JSONConstructor> {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getData(url: String, completion: @escaping ([T]?, Error?) -> ()) {
        let url = networkManager.url(for: url)!
        networkManager.get(from: url) { (json, error) in
            if let json = json, let arrayObjectKey = T.jsonArrayKey {
                let objects = json[arrayObjectKey].map({ (_, json)  -> T in
                    return T.mapFromJSON(json: json)
                })
                completion(objects, nil)
            }
            
            if let error = error {
                completion(nil, error)
            }
        }
    }
}
