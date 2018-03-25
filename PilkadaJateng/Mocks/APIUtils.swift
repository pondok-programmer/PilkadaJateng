//
//  APIUtils.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import Foundation

struct APIUtils {
    private init() {}
    static let baseUrlAPI = "http://api.pemiluapi.org/pilkada_banten/api/"
    
    // MARK: Informasi Pilkada
    static var partisipasiPilkada: String {
        return baseUrlAPI + "partisipasi_pilkada"
    }
    
    static var anggaranPilkada: String {
        return baseUrlAPI + "anggaran_pilkada"
    }
    
    static var tahapanPilkada: String {
        return baseUrlAPI + "tahapan_pilkada"
    }
    
    // MARK: Informasi Calon
    static var profileCalon: String {
        return baseUrlAPI + "profile_calon"
    }
    
    /// Non - Petahana
    static var visiMisiWahidinAndika: String {
        return baseUrlAPI + "visi_misi_wahidin_andika"
    }
    
    /// Non - Petahana
    static var prioritasProgramWahidinAndika: String {
        return baseUrlAPI + "prioritas_program_wahidin_andika"
    }
    
    /// Petahana
    static var visiMisiRanoEmbay: String {
        return baseUrlAPI + "visi_misi_rano_embay"
    }
    
    /// Petahana
    static var programUnggulanRanoEmbay: String {
        return baseUrlAPI + "program_unggulan"
    }
    
    /// Petahana
    static var lhkpnRano: String {
        return baseUrlAPI + "lhkpn_rano"
    }
}
