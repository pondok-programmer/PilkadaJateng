//
//  TambahTipsViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/17/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet

protocol _TambahTipsDelegateViewController: class {
    func finish(_ materiWacana: MateriWacana)
}

class TambahTipsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let nib = UINib(nibName: "DaftarMateriTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DaftarMateriCell")
        setupDZNDataSet()
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
            vc.nomorMateri = _daftarMateri.count + 1
        }
    }
    
    @IBAction func batal() {
        dismiss(animated: true, completion: nil)
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

extension TambahTipsViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func setupDZNDataSet() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Belum Ada Materi"
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tambahkan mininal satu materi agar lebih bermanfaat."
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView?) -> UIImage? {
        return UIImage(named: "light_100")
    }
}


fileprivate let textViewPlaceholder = "Isi materi..."

class TambahMateriViewController: UIViewController {
    
    weak var delegate: _TambahMateriDelegateViewController?
    
    @IBAction func selesaiButton(_ sender: UIButton) {
        if let title = subjudulTextField.text,
            let content = isiTextView.text {
           delegate?.finish((title, content))
        }
        mydismiss()
    }
    
    @IBAction func batalButton() {
        mydismiss()
    }
    
    func mydismiss() {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.backgroundColor = .clear
        }) { (isCompleted) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var nomorMateri: Int = 0
    
    @IBOutlet weak var nomorLabel: UILabel!
    @IBOutlet weak var subjudulTextField: UITextField!
    @IBOutlet weak var isiTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        nomorLabel.text = "Nomor \(nomorMateri)"
        isiTextView.layer.borderWidth = 0.5
        isiTextView.layer.borderColor = UIColor.gray.cgColor
        subjudulTextField.layer.borderWidth = 0.5
        subjudulTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        })
    }
    
    func setupTextView() {
        let textView = isiTextView
        textView?.delegate = self
        textView?.text = textViewPlaceholder
        textView?.textColor = .lightGray
    }
}

extension TambahMateriViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == textViewPlaceholder)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
