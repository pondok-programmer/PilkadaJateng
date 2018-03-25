//
//  InformasiPilkadaService.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

class InformasiPilkadaService {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    enum InfoType {
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
    
    func getData(completion: @escaping (String?, Error?) -> ()) {
        let url = networkManager.url(for: APIUtils.tahapanPilkada)!
        networkManager.get(from: url) { (str, error) in
            completion(str, error)
        }
    }
}
