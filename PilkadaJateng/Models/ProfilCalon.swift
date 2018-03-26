//
//  InformasiCalon.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

struct ProfilCalon {
    let wilayah: String
    let provinsi: String
    let namaKepalaDaerah: String
    let genderKepalaDaerah: String
    let tempatLahirKepalaDaerah: String
    let tanggalLahirKepalaDaerah: Date
    let pekerjaanKepalaDaerah: String
    
    let namaWakilKepalaDaerah: String
    let genderWakilKepalaDaerah: String
    let tempatLahirWakilKepalaDaerah: String
    let tanggalLahirWakilKepalaDaerah: Date
    let pekerjaanWakilKepalaDaerah: String
    
    let jumlahDukungan: Int
    let perolehanSuara: Int
    
    let isPetahana: Bool
    let statusPetahana: String
    
    let partaiPendukung: String
}
