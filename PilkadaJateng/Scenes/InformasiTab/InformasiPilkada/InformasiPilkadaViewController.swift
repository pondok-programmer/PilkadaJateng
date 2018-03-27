//
//  InformasiPilkadaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class InformasiPilkadaViewController: UIViewController {
    @IBOutlet weak var viewOutlets: InformasiPilkadaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupPartisipasiPilkadaButton()
        _setupAnggaranPilkadaButton()
        _setupTahapanPilkadaButton()
    }
    
    private func _setupPartisipasiPilkadaButton() {
        let button = viewOutlets.partisipasiPilkadaButton
        button?.addTarget(self, action: .infoPartisipasiPilkada, for: .touchUpInside)
    }
    
    private func _setupAnggaranPilkadaButton() {
        let button = viewOutlets.anggaranPilkadaButton
        button?.addTarget(self, action: .infoAnggaranPilkada, for: .touchUpInside)
    }
    
    private func _setupTahapanPilkadaButton() {
        let button = viewOutlets.tahapanPilkadaButton
        button?.addTarget(self, action: .infoTahapanPilkada, for: .touchUpInside)
    }
    
    @objc func goToInfoPartisipasiPilkada() {
        performSegue(withIdentifier: "InfoPartisipasiViewController", sender: nil)
    }
    
    @objc func goToInfoAnggaranPilkada() {
        performSegue(withIdentifier: "InfoAnggaranViewController", sender: nil)
    }
    
    @objc func goToInfoTahapanPilkada() {
        performSegue(withIdentifier: "InfoTahapanViewController", sender: nil)
    }
}

fileprivate extension Selector {
    static let infoPartisipasiPilkada = #selector(InformasiPilkadaViewController.goToInfoPartisipasiPilkada)
    static let infoAnggaranPilkada = #selector(InformasiPilkadaViewController.goToInfoAnggaranPilkada)
    static let infoTahapanPilkada = #selector(InformasiPilkadaViewController.goToInfoTahapanPilkada)
}

class InformasiPilkadaView: UIView {
    @IBOutlet weak var partisipasiPilkadaButton: UIButton!
    @IBOutlet weak var anggaranPilkadaButton: UIButton!
    @IBOutlet weak var tahapanPilkadaButton: UIButton!
}
