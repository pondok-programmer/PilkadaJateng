//
//  Tester.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tester {
    static let shared = Tester()
    private init() {}
    
    func run() {
        let m = MOCKMateriWancanaNetworkManager()
        WacanaService(networkManager: m).getData(url: "http://g.com") { (data, error) in
            print(data![0].judul)
        }
    }
}
