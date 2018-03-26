//
//  Tester.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

class Tester {
    static let shared = Tester()
    private init() {}
    
    func run() {
        let n = MockProvider.shared.makeProfilCalonNetworkMock()
        let i = InformasiService<ProfilCalon>(networkManager: n)
        let u = InformasiType.profilCalon.getUrl()
        i.getData(url: u ) { (data, error) in
            data?.forEach({ (p) in
                print(p)
                print("\n\n")
            })
        }
    }
}
