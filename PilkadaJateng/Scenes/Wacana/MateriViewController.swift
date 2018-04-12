//
//  MateriViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/11/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class MateriViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var materi: DaftarMateri!
    var number: Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = materi.title
        contentLabel.text = materi.content
        numberLabel.text = "- \(number) -"
    }
}
