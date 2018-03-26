//
//  ProfilCalon+Ext.swift
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
 "wilayah": "Provinsi Banten",
 "provinsi": "Banten",
 "nama_kepala_daerah": "Dr. H. WAHIDIN HALIM, MSi",
 "gender_kepala_daerah": "Laki-laki",
 "tempat_lahir_kepala": "Tangerang",
 "tanggal_lahir_kepala": "14/08/1954",
 "pekerjaan_kepala": "DPR",
 "nama_wakil_kepala_daerah": "H. ANDIKA HAZRUMY, S.Sos., M.AP",
 "gender_wakil_kepala_daerah": "Laki-laki",
 "tempat_lahir_wakil": "Bandung",
 "tanggal_lahir_wakil": "16/12/1985",
 "pekerjaan_wakilkada": "DPR",
 "jumlah_dukungan": null,
 "perolehan_suara": null,
 "petahana": "Tidak",
 "status_petahana": "Tidak",
 "partai_pendukung": "PKB, PKS, Golkar,Gerindra, Demokrat, PAN, Hanura"
 }
 */


fileprivate let dateFormat = "dd/MM/yyyy"
fileprivate let boolRepresentation = String.BoolRepresentation(true: "Ya", false: "Tidak")

extension ProfilCalon: JSONConstructor {
    static var jsonArrayKey: String? {
        return "result"
    }
    
    static func mapFromJSON(json: JSON) -> ProfilCalon {
        let wilayah = json["wilayah"].string.or("")
        let provinsi = json["provinsi"].string.or("")
        let nama_kepala_daerah = json["nama_kepala_daerah"].string.or("")
        let gender_kepala_daerah = json["gender_kepala_daerah"].string.or("")
        let tempat_lahir_kepala = json["tempat_lahir_kepala"].string.or("")
        let tanggal_lahir_kepala = json["tanggal_lahir_kepala"].string.or("")
            .toDate(format: dateFormat).or(Date())
        let pekerjaan_kepala = json["pekerjaan_kepala"].string.or("")
        
        let nama_wakil_kepala_daerah = json["nama_wakil_kepala_daerah"].string.or("")
        let gender_wakil_kepala_daerah = json["gender_wakil_kepala_daerah"].string.or("")
        let tempat_lahir_wakil = json["tempat_lahir_wakil"].string.or("")
        let tanggal_lahir_wakil = json["tanggal_lahir_wakil"].string.or("")
            .toDate(format: dateFormat).or(Date())
        let pekerjaan_wakilkada = json["pekerjaan_wakilkada"].string.or("")
        
        let jumlah_dukungan = json["jumlah_dukungan"].string.or("")
            .toInt().or(0)
        let perolehan_suara = json["perolehan_suara"].string.or("")
            .toInt().or(0)
        
        let petahana = json["petahana"].string.or("")
            .toBool(boolRepresentation)
        let status_petahana = json["status_petahana"].string.or("")
        let partai_pendukung = json["partai_pendukung"].string.or("")
        
        return ProfilCalon(wilayah                      : wilayah,
                           provinsi                     : provinsi,
                           namaKepalaDaerah             : nama_kepala_daerah,
                           genderKepalaDaerah           : gender_kepala_daerah,
                           tempatLahirKepalaDaerah      : tempat_lahir_kepala,
                           tanggalLahirKepalaDaerah     : tanggal_lahir_kepala,
                           pekerjaanKepalaDaerah        : pekerjaan_kepala,
                           namaWakilKepalaDaerah        : nama_wakil_kepala_daerah,
                           genderWakilKepalaDaerah      : gender_wakil_kepala_daerah,
                           tempatLahirWakilKepalaDaerah : tempat_lahir_wakil,
                           tanggalLahirWakilKepalaDaerah: tanggal_lahir_wakil,
                           pekerjaanWakilKepalaDaerah   : pekerjaan_wakilkada,
                           jumlahDukungan               : jumlah_dukungan,
                           perolehanSuara               : perolehan_suara,
                           isPetahana                   : petahana,
                           statusPetahana               : status_petahana,
                           partaiPendukung              : partai_pendukung)
    }
}
