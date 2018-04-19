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
    
    @IBAction func toVisi(_ sender: UIButton) {
        performSegue(withIdentifier: "VisiVC", sender: _profil?.visi)
    }
    
    @IBAction func toMisi(_ sender: UIButton) {
        performSegue(withIdentifier: "ProgramVC", sender: ("Misi" ,_profil?.misi))
    }
    
    @IBAction func toProgram(_ sender: UIButton) {
        performSegue(withIdentifier: "ProgramVC", sender: ("Program", _profil?.program))
    }
    
    @IBAction func toDetail(_ sender: UIButton) {
        performSegue(withIdentifier: "ProgramVC", sender: ("Detail", _profil?.detail))
    }
    
    @IBAction func selesaiButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _fetchData()
        title = "Profil Paslon"
        plainNavigationBackButton()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController else { return }
        
        if let vc = navVC.viewControllers.first as? VisiViewController, let visi = sender as? String {
            vc.visi = visi
        } else if let vc = navVC.viewControllers.first as? ProgramTableViewController, let data = sender as? (String, [String]) {
            vc.title = data.0
            vc.data = data.1
        }
    }
    
    
    /// Array index in Queue, index is 0 for profil 1
    var profilNumber: Int = 0
    
    private func _fetchData() {
        _service.getData { [unowned self](profils, error) in
            self._profil = profils?[self.profilNumber]
        }
    }
    
    private let paslonImages = [
        [UIImage(named: "ganjar_pranowo"), UIImage(named:"taj_yasin")],
        [UIImage(named: "sudirman_said"), UIImage(named: "ida_fauziyah")]
    ]
    
    private func _setupInfoKepalaDaerah() {
        let v = infoKepalaDaerah
        v?.image.image = paslonImages[profilNumber][0]
        v?.namaLabel.text = _profil?.namaKepalaDaerah
        v?.tempatTanggalLahirLabel.text = "\((_profil?.tempatLahirKepalaDaerah).or("")), \((_profil?.tanggalLahirKepalaDaerah.toString(format: "dd MMM yyyy")).or(""))"
        v?.pekerjaanLabel.text = _profil?.pekerjaanKepalaDaerah
    }
    
    private func _setupInfoWakilKepalaDaerah() {
        let v = infoWakilKepalaDaerah
        v?.image.image = paslonImages[profilNumber][1]
        v?.namaLabel.text = _profil?.namaWakilKepalaDaerah
        v?.tempatTanggalLahirLabel.text = "\((_profil?.tempatLahirWakilKepalaDaerah).or("")), \((_profil?.tanggalLahirWakilKepalaDaerah.toString(format: "dd MMM yyyy")).or(""))"
        v?.pekerjaanLabel.text = _profil?.pekerjaanWakilKepalaDaerah
    }
    
    private func _setupMediaSosial() {
        let v = mediaSosial
        
        let fbImage = UIImage(named: "facebook_color")
        if let fb = _profil?.facebook {
            v?.facebookButton.setImage(fbImage, for: .normal)
            v?.facebookButton.addTarget(self,
                                        action: #selector(toFacebook),
                                        for: .touchUpInside)
        } else {
            v?.facebookButton.setImage(fbImage?.noir, for: .normal)
        }
        
        let igImage = UIImage(named: "instagram_color")
        if let ig = _profil?.instagram {
            v?.instagramButton.setImage(igImage, for: .normal)
            v?.instagramButton.addTarget(self,
                                         action: #selector(toInstagram),
                                         for: .touchUpInside)
        } else {
            v?.instagramButton.setImage(igImage?.noir, for: .normal)
        }
        
        let twImage = UIImage(named: "twitter_color")
        if let tw = _profil?.twitter {
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
            let message = _profil!.facebook.isEmpty ? "Paslon belum memiliki akun Facebook" : "Tidak bisa membuka URL : \(_profil!.facebook)"
            showAlert(title: message)
        }
    }
    
    @objc func toInstagram() {
        if let _ = URL(string: _profil!.instagram ) {
            
        } else {
            let message = _profil!.instagram.isEmpty ? "Paslon belum memiliki akun Instagram" : "Tidak bisa membuka URL : \(_profil!.instagram)"
            showAlert(title: message)
        }
    }
    
    @objc func toTwitter() {
        if let _ = URL(string: _profil!.twitter ) {
            
        } else {
            let message = _profil!.twitter.isEmpty ? "Paslon belum memiliki akun Twitter" : "Tidak bisa membuka URL : \(_profil!.twitter)"
            showAlert(title: message)
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
