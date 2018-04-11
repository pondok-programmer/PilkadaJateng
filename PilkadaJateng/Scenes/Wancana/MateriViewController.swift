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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = materi.title
        contentLabel.text = materi.content
    }
}
