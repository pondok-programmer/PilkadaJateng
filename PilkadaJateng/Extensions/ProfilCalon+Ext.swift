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


extension PJProfil: JSONInitializable {
    init(_ json: JSON) {
        /*
         {
         "jumlah_dukungan": 0,
         "tanggal_lahir_kepala_daerah": "28/10/1968",
         "tempat_lahir_wakil": "REMBANG",
         "tanggal_lahir_wakil": "2/7/1983",
         "pekerjaan_wakil_kepala_daerah": "ANGGOTA DPRD PROVINSI JAWA TENGAH",
         "pekerjaan_kepala_daerah": "GUBERNUR",
         "media_sosial_instagram": null,
         "wilayah": "PROVINSI JAWA TENGAH",
         "status_petahana": "YA",
         "visimisi": {
         "misi": [
         "Menempatkan rakyat (petani. nelayan, pelaku usaha mikro den kecil serta rakyat pekerja) sebagai subyek  dalam proses pengambilan keputusan dan penentuan arah pembangunan  serta memperkuat akses rakyat terhadap sumberdaya politik, ekonomi sosial dan budaya",
         "Memperkuat penyelengara pemerintahan yang bersih, jujur, transparan demi terjaminnya sistem pelayanan publik untuk memenuhi kebutuhan dasar rakyat, terciptanya relasi sosial yang aman dan tidak diskrinimatif",
         "Menyelenggarakan program-program pembangunan yang menjamin terwujudnya kesejahteraan rakyat melalui sinergitas kerja dan gotong royong para pemangku kepentingan"
         ],
         "program": [
         "Pendidikan politik dan pemberdayaan masyarakat",
         "Reformasi Birokrasi",
         "Peningkatan Kesejahteraan Masyarakat",
         "Peningkatan pembangunan lnfrastruktur",
         "Peningkatan kualitas lingkungan hidup dan energi",
         "Pengembangan Kebudayaan"
         ],
         "detail": [
         "Menanamkan nilai-nilai spritual dan kebangsaan melalui pendidikan, pelatihan dan pendampingan masyarakat.",
         "Mengkonsolidasikan dan menyinergikan seluruh kekuatan Satuan Kerja Perangkat Daerah melalui sistim pelayanan yang berpihak pada kepentingan publik",
         "Terpenuhinya kebutuhan hidup dasar warga dan terciptanya relasi sosial yang aman dan tidak diskriminatif melalui kerjasama kemitraan, investasi, pemberian bantuan dan gotong royong semua pemangku kepentingan",
         "Pengembangan infrastruktur sosial, ekonomi, politik dan kebudayaan dengan menjaga, memelihara dan meningkatkan kualitas dan kuantitas infrastruktur",
         "Menjamin keberlangsungan hidup manusia dan sumberdaya alam yang aman dan berkelanjutan melalui pengembangan teknologi ramah lingkungan, konservasi alam dan ekosistem, pengurangan resiko bencana, mengembangkan pemanfaatan energi baru terbarukan",
         "Mengembangkan nilai-nilai dan menguatkan identitas kebudayaan Jawa Tengah melalui pengakuan keragaman budaya dan memfasilitasi ruang-ruang ekspresi dan kreasi berbagai budaya yang hidup di masyarakat"
         ],
         "visi": "Menuju Jawa Tengah Sejahtera dan Berdikari: Mboten Korupsi, Mboten Ngapusi."
         },
         "partai_pendukung": "PDI-P, PPP, DEMOKRAT, NASDEM ",
         "media_sosial_facebook": null,
         "nama_wakil_kepala_daerah": "H. TAJ YASIN",
         "tempat_lahir_kepala_daerah": "KARANGANYAR",
         "nama_kepala_daerah": "H. GANJAR PRANOWO, S.H., M.IP",
         "provinsi": "JAWA TENGAH",
         "gender_wakil_kepala_daerah": "LAKI-LAKI",
         "gender_kepala_daerah": "LAKI-LAKI",
         "media_sosial_twitter": null
         }
         */
        
        jumlahDukungan = json["jumlah_dukungan"].int.or(0)
        
        namaKepalaDaerah = json["nama_kepala_daerah"].string.or("")
        tempatLahirKepalaDaerah = json["tempat_lahir_kepala_daerah"].string.or("")
        tanggalLahirKepalaDaerah = json["tanggal_lahir_kepala_daerah"].string.or("")
            .toDate(format: "dd/MM/yyyy")
            .or(Date())
        
        pekerjaanKepalaDaerah = json["pekerjaan_kepala_daerah"].string.or("")
        genderKepalaDaerah = json["gender_kepala_daerah"].string.or("")
        
        namaWakilKepalaDaerah = json["nama_wakil_kepala_daerah"].string.or("")
        tempatLahirWakilKepalaDaerah = json["tempat_lahir_wakil_kepala_daerah"].string.or("")
        tanggalLahirWakilKepalaDaerah = json["tanggal_lahir_wakil_kepala_daerah"].string.or("")
            .toDate(format: "dd/MM/yyyy")
            .or(Date())
        
        pekerjaanWakilKepalaDaerah = json["pekerjaan_wakil_kepala_daerah"].string.or("")
        genderWakilKepalaDaerah = json["fender_wakil_kepala_daerah"].string.or("")
        
        facebook = json["media_sosial_facebook"].string.or("")
        instagram = json["media_sosial_instagram"].string.or("")
        twitter = json["media_sosial_twitter"].string.or("")
        
        provinsi = json["provinsi"].string.or("")
        partaiPendukung = json["partai_pendukung"].string.or("")
        wilayah = json[""].string.or("wilayah")
        isPetahana = json["status_petahana"].string.or("")
            .toBool(String.BoolRepresentation(true: "YA", false: "TIDAK"))
        
        let visiMisi = json["visimisi"]
        
        visi = visiMisi["visi"].string.or("")
        misi = visiMisi["misi"].array.or([])
            .map({$0.string.or("")})
        program = visiMisi["program"].array.or([])
            .map({$0.string.or("")})
        detail = visiMisi["detail"].array.or([])
            .map({$0.string.or("")})
    }
}
