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
        return User(id: "klaus", name: "Muiz")
    }
    
    func makePartisipasiNetworkMock() -> NetworkManager {
        return MOCKPartisipasiNetworkManager()
    }
    
    func makeAnggaranNetworkMock() -> NetworkManager {
        return MOCKAnggaranNetworkManager()
    }
    
    func makeTahapanNetworkMock() -> NetworkManager {
        return MOCKTahapanNetworkManager()
    }
    
    func makeProfilCalonNetworkMock() -> NetworkManager {
        return MOCKProfilCalonNetworkManager()
    }
    
    func makeVisiMisi() -> [VisiMisiCalon] {
        return [VisiMisiCalon(visi: "Sehat", misi: "Bahagia"),
                VisiMisiCalon(visi: "Tampan", misi: "Tampan")]
    }
    
    func makeProgramUnggulan() -> [ProgramUnggulanCalon] {
        return [ProgramUnggulanCalon(programUnggulan: "PUC1",
                                     deskripsi: "d1",
                                     detailDeskripsi: "dd1"),
                ProgramUnggulanCalon(programUnggulan: "PUC2",
                                     deskripsi: "d2",
                                     detailDeskripsi: "dd2")]
    }
    
    func makePrioritasProgram() -> [PrioritasProgramCalon] {
        return [PrioritasProgramCalon(prioritasProgram: "PP1", deskripsi: "d1"),
                PrioritasProgramCalon(prioritasProgram: "PP2", deskripsi: "d2")]
    }
    
    func makeLHKPN() -> [LHKPN] {
        return [1,2,3,4].map({ (i) -> LHKPN in
            return LHKPN(jenisHarta: "H\(i)",
                keterangan: "k\(i)",
                nilai: 0.0 + Double(i),
                tahun: 2000 + i,
                status: "s\(i)")
        })
    }
    
    
    /// Visit pemilu.org to get your API KEY
    ///
    /// - Returns: API Key
    func getAPIKey() -> String {
        return APIKEY()
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

class MOCKTahapanNetworkManager: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "tahapan_pilkada", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}

class MOCKProfilCalonNetworkManager: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "profile_calon", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}

class MOCKBeritaPilkadaNetworkManager: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "berita_pilkada", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}

class MOCKMateriWancanaNetworkManager: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "materi_wacana", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}

class MOCKTahapan: NetworkManager {
    override func get(from url: URL, completion: @escaping (JSON?, Error?) -> ()) {
        if let data = resource(name: "tahapan_pilkada_2018", ofType: "json") {
            let json = JSON(data)
            completion(json, nil)
        } else {
            completion(nil, nil)
        }
    }
}


