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

extension AnggaranPilkada: JSONConstructor {
    static var jsonArrayKey: String? {
        return "anggaran_pilkada"
    }
    
    static func mapFromJSON(json: JSON) -> AnggaranPilkada {
        let detil_anggaran = json["detil_anggaran"].string.or("")
        let jumlah_anggaran = json["jumlah_anggaran"].string.or("")
            .removeChar([",", " "])
            .toDouble().or(0.0)
        let status_anggaran = json["status_anggaran"].string.or("")
        return AnggaranPilkada(detilAnggaran: detil_anggaran,
                               jumlahAnggaran: jumlah_anggaran,
                               statusAnggaran: status_anggaran)
    }
}

/*
 {
 "nama_wakil_kepala_daerah": "Dra. IDA FAUZIAH",
 "no urut": 2,
 "tanggal_penyerahan": "14-Feb-2018",
 "laporan_awal_dana_kampanye": " 550,000,000 ",
 "waktu_penyerahan": "pukul 17.26 wib",
 "nama_kepala_daerah": "SUDIRMMAN SAID"
 }
 */

extension PJAnggaran: JSONInitializable {
    init(_ json: JSON) {
        kepalaDaerah = json["nama_kepala_daerah"].string.or("")
        wakilKepalaDaerah = json["nama_wakil_kepala_daerah"].string.or("")
        tanggalPenyerahan = json["tanggal_penyerahan"].string.or("")
            .toDate(format: "dd-MMM-yyyy").or(Date())
        waktuPenyerahan = json["waktu_penyerahan"].string.or("")
            .toDate(format: "'pukul' HH.mm 'wib'").or(Date())
        laporanAwalDana = json["laporan_awal_dana_kampanye"].string.or("")
            .removeChar([",", " "])
            .toDouble().or(0.0)
        noUrut = json["no urut"].int.or(0)
    }
}
