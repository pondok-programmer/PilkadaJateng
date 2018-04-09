//
//  InformasiViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class InformasiViewController: UIViewController {
    @IBOutlet weak var viewOutlets: InformasiView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        title = "Informasi"
        
        _setupPilkadaButton()
        _setupCalonButton()
    }
    
    private func _setupPilkadaButton() {
        let pilkadaButton = viewOutlets.pilkadaButton
        pilkadaButton?.addTarget(self, action: .informasiPilkadaAction, for: .touchUpInside)
    }
    
    private func _setupCalonButton() {
        let calonButton = viewOutlets.calonButton
        calonButton?.addTarget(self, action: .informasiCalonAction, for: .touchUpInside)
    }
    
    @objc func _goToInformasiPilkada() {
        performSegue(withIdentifier: "InformasiPilkadaViewController", sender: nil)
    }
    
    @objc func _goToInformasiCalon() {
        performSegue(withIdentifier: "InformasiCalonViewController", sender: nil)
    }
    
    @IBAction func unwindInformasiViewController(_ segue: UIStoryboardSegue) {
    }
}

fileprivate extension Selector {
    static let informasiPilkadaAction = #selector(InformasiViewController._goToInformasiPilkada)
    static let informasiCalonAction = #selector(InformasiViewController._goToInformasiCalon)
}

class InformasiView: UIView {
    @IBOutlet weak var pilkadaButton: UIButton!
    @IBOutlet weak var calonButton: UIButton!
}
