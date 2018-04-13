//
//  ProfilViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/12/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import MapKit

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
    @IBOutlet weak var program: _ProgramView!
    @IBOutlet weak var petaPolitik: _PetaPolitikView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _setupMapKit()
    }

    let initialLocation = CLLocation(latitude: -7.150975, longitude: 110.1402594) // Jawa Tengah
    let northEastLocation = CLLocation(latitude: -5.725698, longitude: 111.6914889)
    let southWestLocation = CLLocation(latitude: -8.2116361, longitude: 108.555502)
    private func _setupMapKit() {
        centerMapOnLocation(location: initialLocation)
        let northDistance = northEastLocation.distance(from: initialLocation)
        let southDistance = southWestLocation.distance(from: initialLocation)
        print("n: \(northDistance) s: \(southDistance)")
    }
    
    let regionRadius: CLLocationDistance = 1000
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  233002.881153669,
                                                                  210546.047670233)
        petaPolitik.mapView.setRegion(coordinateRegion, animated: true)
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

class _ProgramView: CardView {
    @IBOutlet weak var visi: UILabel!
    @IBOutlet weak var misi: UILabel!
    @IBOutlet weak var program: UILabel!
    @IBOutlet weak var detail: UILabel!
}

class _PetaPolitikView: CardView {
    @IBOutlet weak var jumlahDukungan: UILabel!
    @IBOutlet weak var partaiPendukung: UILabel!
    @IBOutlet weak var wilayah: UILabel!
    @IBOutlet weak var isPetahana: UILabel!
    @IBOutlet weak var mapView: MKMapView!
}
