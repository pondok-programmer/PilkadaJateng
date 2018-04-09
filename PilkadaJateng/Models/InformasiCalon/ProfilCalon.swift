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


struct PJProfil {
    let jumlahDukungan: Int
    
    let namaKepalaDaerah: String
    let tempatLahirKepalaDaerah: String
    let tanggalLahirKepalaDaerah: Date
    let pekerjaanKepalaDaerah: String
    let genderKepalaDaerah: String
    
    let namaWakilKepalaDaerah: String
    let tempatLahirWakilKepalaDaerah: String
    let tanggalLahirWakilKepalaDaerah: Date
    let pekerjaanWakilKepalaDaerah: String
    let genderWakilKepalaDaerah: String
    
    let facebook: String
    let instagram: String
    let twitter: String
    
    let provinsi: String
    let partaiPendukung: String
    let wilayah: String
    let isPetahana: Bool
    
    let visi: String
    let misi: [String]
    let program: [String]
    let detail: [String]
}


