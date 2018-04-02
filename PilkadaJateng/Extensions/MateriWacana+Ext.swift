//
//  MateriWacana+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/2/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

extension MateriWacana: JSONInitializable {
    init(_ json: JSON) {
        judul = json["judul"].string.or("")
        alasan = json["alasan"].string.or("")
        ringkasan = json["ringkasan"].string.or("")
        sumberUrl = json["sumber"].string.or("")
        daftarMateri = json["daftar_materi"].array.or([])
            .map({ DaftarMateri($0) })
    }
}

extension DaftarMateri: JSONInitializable {
    init(_ json: JSON) {
        title = json["title"].string.or("")
        content = json["content"].string.or("")
    }
}
