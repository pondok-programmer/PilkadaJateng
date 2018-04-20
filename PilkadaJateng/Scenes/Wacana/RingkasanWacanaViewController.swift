//
//  RingkasanWacanaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/20/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import SafariServices

class RingkasanWacanaViewController: UIViewController {
    var materiWacana: MateriWacana!
    
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var deskripsiTextView: UITextView!
    @IBOutlet weak var ringkasanTextView: UITextView!
    @IBOutlet weak var sumberButton: UIButton!
    
    @IBAction func bukaSumber() {
        if let url = URL(string: materiWacana.sumberUrl) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        } else {
            
        }
    }
    
    @IBAction func lihatMateri() {
        let vc = DaftarMateriViewController(nibName: "DaftarMateriViewController", bundle: nil)
        vc.materiWacana = materiWacana
        show(vc, sender: nil)
    }
    
    @IBAction func selesai() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        judulLabel.text = materiWacana.judul
        deskripsiTextView.text = materiWacana.alasan
        ringkasanTextView.text = materiWacana.ringkasan
        sumberButton.setTitle(materiWacana.sumberUrl, for: .normal)
    }
}
