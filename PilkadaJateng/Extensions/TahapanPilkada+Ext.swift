//
//  TahapanPilkada.swift
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
 "tahapan_pilkada": "Pendaftaran pasangan calon",
 "awal": "19-Sep-16",
 "akhir": "21-Sep-16"
 }
 */

extension TahapanPilkada: JSONConstructor {
    static var jsonArrayKey: String? {
        return "tahapan_pilkada"
    }
    
    static func mapFromJSON(json: JSON) -> TahapanPilkada {
        let tahapan_pilkada = json["tahapan_pilkada"].string.or("")
        let awal = json["awal"].string.or("").toDate(format: "dd-MMM-yy" ).or(Date())
        let akhir = json["akhir"].string.or("").toDate(format: "dd-MMM-yy" ).or(Date())
        return TahapanPilkada(tahapanPilkada: tahapan_pilkada,
                              awal: awal,
                              akhir: akhir)
    }
}
