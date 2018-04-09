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
        return "tahapan"
    }
    
    static func mapFromJSON(json: JSON) -> TahapanPilkada {
        let tahapan = json["tahapan"].string.or("")
        let detail = json["detail"].string.or("")
        let awal = json["awal"].string.or("").toDate(format: "dd-MMM-yy" ).or(Date())
        let akhir = json["akhir"].string.or("").toDate(format: "dd-MMM-yy" ).or(Date())
        return TahapanPilkada(tahapan: tahapan,
                              detail: detail,
                              awal: awal,
                              akhir: akhir)
    }
}

extension TahapanPilkada: JSONInitializable {
    init(_ json: JSON) {
        tahapan = json["tahapan"].string.or("")
        detail = json["detail"].string.or("")
        awal = json["tgl_awal"].string.or("").toDate(format: "dd-MMM-yy" ).or(Date())
        akhir = json["tgl_akhir"].string.or("").toDate(format: "dd-MMM-yy" ).or(Date())
    }
}

