//
//  AnggaranPilkada+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 {
 "id": 1,
 "detil_anggaran": "Anggaran Diajukan",
 "jumlah_anggaran": " 299,802,120,000 ",
 "status_anggaran": "Anggaran Total",
 "created_at": null,
 "updated_at": null
 }
 */

fileprivate extension String {
    func removeCommaCharacter() -> String {
        let chars: [Character] = [",", " "]
        let string = String(chars)
        return components(separatedBy: CharacterSet(charactersIn: string)).joined()
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
}



extension AnggaranPilkada: JSONConstructor {
    static var jsonArrayKey: String? {
        return "anggaran_pilkada"
    }
    
    static func mapFromJSON(json: JSON) -> AnggaranPilkada {
        let detil_anggaran = json["detil_anggaran"].string.or("")
        let jumlah_anggaran = json["jumlah_anggaran"].string.or("")
            .removeCommaCharacter()
            .toDouble().or(0.0)
        let status_anggaran = json["status_anggaran"].string.or("")
        return AnggaranPilkada(detilAnggaran: detil_anggaran,
                               jumlahAnggaran: jumlah_anggaran,
                               statusAnggaran: status_anggaran)
    }
}
