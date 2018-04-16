//
//  InformasiViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

fileprivate let tanggalPilkada = "27 Jun 2018 00:00"
fileprivate let format = "dd MMM yyyy HH:mm"

class InformasiViewController: UIViewController {
    @IBOutlet weak var viewOutlets: InformasiView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupPilkadaButton()
        _setupCalonButton()
        _setupTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBarControllerNavigationItem { (navItem) in
            navItem?.rightBarButtonItem = nil
        }
    }
    
    @IBOutlet weak var hariLabel: UILabel!
    @IBOutlet weak var jamLabel: UILabel!
    @IBOutlet weak var menitLabel: UILabel!
    @IBOutlet weak var detikLabel: UILabel!
    
    private func _setupTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(updateHitungMundurPilkada),
                                         userInfo: nil,
                                         repeats: true)
        timer.fire()
    }
    
    @objc func updateHitungMundurPilkada() {
        if let hDate = tanggalPilkada.toDate(format: format) {
            let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: hDate)
            hariLabel.text = "\(components.day.or(0))"
            jamLabel.text = "\(components.hour.or(0))"
            menitLabel.text = "\(components.minute.or(0))"
            detikLabel.text = "\(components.second.or(0))"
        }
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
