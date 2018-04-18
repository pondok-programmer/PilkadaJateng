//
//  TambahTipsViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/17/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol _TambahTipsDelegateViewController: class {
    func finish(_ materiWacana: MateriWacana)
}

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
        print("Open TambahVC")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TambahMateriViewController {
            vc.delegate = self
        }
    }
    
    weak var delegate: _TambahTipsDelegateViewController?
    
    @IBAction func simpanButton() {
        let dict: [String: Any] = [
            "judul": judulTextField.text.or(""),
            "alasan": deskripsiTextField.text.or(""),
            "ringkasan": ringkasanTextField.text.or(""),
            "sumber": sumberTextField.text.or(""),
            "daftar_materi": _daftarMateri.map({ (o) -> [String: String] in
                return ["title":o.title,
                        "content": o.content]
            })
        ]
        
        let json = JSON(dict)
        let materiWacana = MateriWacana.init(json)
        delegate?.finish(materiWacana)
        dismiss(animated: true, completion: nil)
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

extension TambahTipsViewController: _TambahMateriDelegateViewController {
    func finish(_ materi: (title: String, content: String)) {
        _daftarMateri.append((materi.title, materi.content))
        tableView.reloadData()
    }
}

protocol _TambahMateriDelegateViewController: class {
    func finish(_ materi: (title: String, content: String))
}

class TambahMateriViewController: UIViewController {
    
    weak var delegate: _TambahMateriDelegateViewController?
    
    @IBAction func selesaiButton(_ sender: UIButton) {
        if let title = subjudulTextField.text,
            let content = isiTextView.text {
           delegate?.finish((title, content))
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nomorLabel: UILabel!
    @IBOutlet weak var subjudulTextField: UITextField!
    @IBOutlet weak var isiTextView: UITextView!
}
