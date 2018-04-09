//
//  Tester.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate let url = URL(string: "http://g.com")!

class Tester {
    static let shared = Tester()
    private init() {}
    
    func run() {
        let m = MOCKProfil()
        m.get(from: url) { (json, error) in
            print(json)
        }
        
        let pjS = InformasiProfilService(networkManager: m)
        pjS.getData { (data, error) in
            print(data)
        }
    }
}
