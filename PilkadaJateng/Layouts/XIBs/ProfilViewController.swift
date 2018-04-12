//
//  ProfilViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/12/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

/*
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
*/

class ProfilViewController: UIViewController {

    @IBOutlet weak var infoKepalaDaerah: _InfoOrangView!
    @IBOutlet weak var infoWakilKepalaDaerah: _InfoOrangView!
    @IBOutlet weak var mediaSosial: _MediaSosialView!
    @IBOutlet weak var petaPolitik: _PetaPolitikView!
    @IBOutlet weak var program: _ProgramView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class _InfoOrangView: CardView {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var tempatLahirLabel: UILabel!
    @IBOutlet weak var tanggalLahirLabel: UILabel!
    @IBOutlet weak var pekerjaanLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
}

class _MediaSosialView: CardView {
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var fbImage: UIImageView!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var igImage: UIImageView!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var twImage: UIImageView!
}

class _PetaPolitikView: CardView {
    @IBOutlet weak var jumlahDukungan: UILabel!
    @IBOutlet weak var partaiPendukung: UICollectionView!
    @IBOutlet weak var wilayah: UILabel!
    @IBOutlet weak var isPetahana: UILabel!
}

class _ProgramView: CardView {
    @IBOutlet weak var visi: UILabel!
    @IBOutlet weak var misi: UILabel!
    @IBOutlet weak var program: UILabel!
    @IBOutlet weak var detail: UILabel!
}
