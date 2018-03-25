//
//  PartisipasiPilkada+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 {
 "administrasi_daerah": "Kabupaten",
 "created_at": null,
 "data_pemilihan_lakilaki": "491634",
 "data_pemilihan_perempuan": "471183",
 "data_pemilihan_total": "962817",
 "id": 2,
 "jumlah_disabilitas": "546140",
 "kabupaten_kota": "Pandeglang",
 "partisipasi_disabilitas": "140",
 "penggunaan_hak_pilih_lakilaki": "250505",
 "penggunaan_hak_pilih_perempuan": "295635",
 "penggunaan_hak_pilih_total": "546140",
 "persentase_pemilih": null,
 "persentase_pengguna_disabilitas": 95,
 "suara_sah": "56.72%",
 "suara_tidak_sah": "529281",
 "suara_total": "16859",
 "updated_at": null
 }
 */

extension PartisipasiPilkada: JSONConstructor {
    static func mapFromJSON(json: JSON) -> PartisipasiPilkada {
        let tipeAdministrasiDaerah = json["administrasi_daerah"].string.or(""),
        dataPemilihLakiLaki = json["data_pemilihan_lakilaki"].int.or(0),
        dataPemilihPerempuan = json["data_pemilihan_perempuan"].int.or(0),
        dataPemilihTotal = json["data_pemilihan_total"].int.or(0),
        jumlahDisabilitas = json["jumlah_disabilitas"].int.or(0),
        namaKabupatenKota = json["kabupaten_kota"].string.or(""),
        partisipasiDisabilitas = json["partisipasi_disabilitas"].int.or(0),
        penggunaanHakPilihLakiLaki = json["penggunaan_hak_pilih_lakilaki"].int.or(0),
        penggunaanHakPilihPerempuan = json["penggunaan_hak_pilih_perempuan"].int.or(0),
        penggunaanHakPilihTotal = json["penggunaan_hak_pilih_total"].int.or(0),
        persentasePemilih = json["persentase_pemilih"].double.or(0.0),
        persentasePenggunaDisabilitas = json["persentasi_pengguna_disabilitas"].double.or(0.0),
        suaraSah = json["suara_sah"].int.or(0),
        suaraTidakSah = json["suara_tidak_sah"].int.or(0),
        suaraTotal = json["suara_total"].int.or(0)
        
        return PartisipasiPilkada(tipeAdministrasiDaerah: tipeAdministrasiDaerah,
                                  dataPemilihLakiLaki: dataPemilihLakiLaki,
                                  dataPemilihPerempuan: dataPemilihPerempuan,
                                  dataPemilihTotal: dataPemilihTotal,
                                  jumlahDisabilitas: jumlahDisabilitas,
                                  namaKabupatenKota: namaKabupatenKota,
                                  partisipasiDisabilitas: partisipasiDisabilitas,
                                  penggunaanHakPilihLakiLaki: penggunaanHakPilihLakiLaki,
                                  penggunaanHakPilihPerempuan: penggunaanHakPilihPerempuan,
                                  penggunaanHakPilihTotal: penggunaanHakPilihTotal,
                                  persentasePemilih: persentasePemilih,
                                  persentasePenggunaDisabilitas: persentasePenggunaDisabilitas,
                                  suaraSah: suaraSah,
                                  suaraTidakSah: suaraTidakSah,
                                  suaraTotal: suaraTotal)
    }
}
