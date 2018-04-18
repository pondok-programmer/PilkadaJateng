//
//  TambahTipsViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/17/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class TambahTipsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let nib = UINib(nibName: "DaftarMateriTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DaftarMateriCell")
    }
    
    @IBOutlet weak var judulTextField: UITextField!
    @IBOutlet weak var deskripsiTextField: UITextField!
    @IBOutlet weak var ringkasanTextField: UITextField!
    @IBOutlet weak var sumberTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func tambahMateri(_ sender: UIButton) {
        _daftarMateri.append(("abc", "tds"))
        tableView.reloadData()
    }
    
    @IBAction func simpanButton() {
        let dict: [String: Any] = [
            "judul": judulTextField.text.or(""),
            "alasan": deskripsiTextField.text.or(""),
            "ringkasan": ringkasanTextField.text.or(""),
            "sumber": sumberTextField.text.or(""),
            "daftar_Materi": _daftarMateri.map({ (o) -> [String: String] in
                return ["title":o.title,
                        "content": o.content]
            })
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            
        }
    }
    
    private var _daftarMateri: [(title:String, content: String)] = []
}

extension TambahTipsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _daftarMateri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaftarMateriCell", for: indexPath) as! DaftarMateriTableViewCell
        let d = _daftarMateri[indexPath.row]
        cell.titleLabel.text = d.title
        cell.contentLabel.text = d.content
        return cell
    }
}
