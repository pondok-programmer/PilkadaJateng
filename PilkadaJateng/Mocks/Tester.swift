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
        let m = MOCKBeritaPilkadaNetworkManager()
        m.get(from: m.url(for: "http://g.com")!) { (json, _) in
            if let json = json {
                let l = BeritaItemList(json)
                let i1 = l.items[0]
                print(i1)
            }
        }   
    }
}
