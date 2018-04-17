//
//  VisiViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/16/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class VisiViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Visi"
        plainNavigationBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        visiLabel.text = visi
    }
    
    var visi: String = ""
    
    @IBOutlet weak var visiLabel: UILabel!
    
    @IBAction func selesaiButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
