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
        _fetchData()
    }
    
    private let _service = InformasiProfilService(networkManager: MOCKProfil())
    
    private var _profil: PJProfil? {
        didSet {
            _setupInfoKepalaDaerah()
            _setupInfoWakilKepalaDaerah()
            _setupMediaSosial()
            _setupPetaPolitik()
            
            _setupMapKit()
            _setupResetMapButton()
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
    
    private func _fetchData() {
        _service.getData { (profils, error) in
            self._profil = profils?[0]
        }
    }
    
    private func _setupInfoKepalaDaerah() {
        let v = infoKepalaDaerah
        v?.namaLabel.text = _profil?.namaKepalaDaerah
        v?.tempatTanggalLahirLabel.text = "\((_profil?.tempatLahirKepalaDaerah).or("")), \((_profil?.tanggalLahirKepalaDaerah.toString(format: "dd MMM yyyy")).or(""))"
        v?.pekerjaanLabel.text = _profil?.pekerjaanKepalaDaerah
    }
    
    private func _setupInfoWakilKepalaDaerah() {
        let v = infoWakilKepalaDaerah
        v?.namaLabel.text = _profil?.namaWakilKepalaDaerah
        v?.tempatTanggalLahirLabel.text = "\((_profil?.tempatLahirWakilKepalaDaerah).or("")), \((_profil?.tanggalLahirWakilKepalaDaerah.toString(format: "dd MMM yyyy")).or(""))"
        v?.pekerjaanLabel.text = _profil?.pekerjaanWakilKepalaDaerah
    }
    
    private func _setupMediaSosial() {
        let v = mediaSosial
        
        let fbImage = UIImage(named: "facebook_color")
        if _profil?.facebook != nil {
            v?.facebookButton.setImage(fbImage, for: .normal)
            v?.facebookButton.addTarget(self,
                                        action: #selector(toFacebook),
                                        for: .touchUpInside)
        } else {
            v?.facebookButton.setImage(fbImage?.noir, for: .normal)
        }
        
        let igImage = UIImage(named: "instagram_color")
        if _profil?.instagram != nil {
            v?.instagramButton.setImage(igImage, for: .normal)
            v?.instagramButton.addTarget(self,
                                         action: #selector(toInstagram),
                                         for: .touchUpInside)
        } else {
            v?.instagramButton.setImage(igImage?.noir, for: .normal)
        }
        
        let twImage = UIImage(named: "twitter_color")
        if _profil?.twitter != nil {
            v?.twitterButton.setImage(twImage, for: .normal)
            v?.twitterButton.addTarget(self,
                                       action: #selector(toTwitter),
                                       for: .touchUpInside)
        } else {
            v?.twitterButton.setImage(twImage?.noir, for: .normal)
        }
    }
    
    @objc func toFacebook() {
        if let _ = URL(string: _profil!.facebook ) {
            
        } else {
            showAlert(title: "Couldn't open Facebook URL")
        }
    }
    
    @objc func toInstagram() {
        if let _ = URL(string: _profil!.instagram ) {
            
        } else {
            showAlert(title: "Couldn't open Instagram URL")
        }
    }
    
    @objc func toTwitter() {
        if let _ = URL(string: _profil!.twitter ) {
            
        } else {
            showAlert(title: "Couldn't open Twitter URL")
        }
    }
    
    func showAlert(title: String?, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func _setupPetaPolitik() {
        let v = petaPolitik
        v?.isPetahana.text = "Petahana : \((_profil?.isPetahana).or(false) ? "✅" : "❎")"
        v?.jumlahDukungan.text = "Jumlah Dukungan : \(_profil?.jumlahDukungan ?? 0)"
        v?.wilayah.text = "Wilayah : \(_profil?.wilayah ?? "")"
        v?.partaiPendukung.text = "Partai : \(_profil?.partaiPendukung ?? "")"
    }
    
    // MARK: Map
    private func _setupResetMapButton() {
        let v = petaPolitik
        v?.resetMapButton.addTarget(self,
                                    action: #selector(resetMap),
                                    for: .touchUpInside)
    }
    
    @objc func resetMap() {
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
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var tempatTanggalLahirLabel: UILabel!
    @IBOutlet weak var pekerjaanLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
}

class _MediaSosialView: CardView {
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
}

class _ProgramView: CardView {
    @IBOutlet weak var visi: UIButton!
    @IBOutlet weak var misi: UIButton!
    @IBOutlet weak var program: UIButton!
    @IBOutlet weak var detail: UIButton!
}

class _PetaPolitikView: CardView {
    @IBOutlet weak var jumlahDukungan: UILabel!
    @IBOutlet weak var partaiPendukung: UILabel!
    @IBOutlet weak var wilayah: UILabel!
    @IBOutlet weak var isPetahana: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resetMapButton: UIButton!
}

extension UIImage {
    var noir: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
}
