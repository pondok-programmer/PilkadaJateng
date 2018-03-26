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
        let a = InformasiPilkadaService<TahapanPilkada>(networkManager: MockProvider.shared.makeTahapanNetworkMock())
        a.getData(url: InformasiPilkadaType.partisipasi.getUrl()) { (data, e) in
            data?.forEach({ (p) in
                print(p)
            })
        }
    }
}
