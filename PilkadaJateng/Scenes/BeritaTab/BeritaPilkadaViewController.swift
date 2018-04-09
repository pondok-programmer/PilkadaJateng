//
//  BeritaPilkadaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

fileprivate let dateStringFormat = "eeee, dd MMM yyyy hh:mm a"

class BeritaPilkadaViewController: UIViewController {
    @IBOutlet weak var viewOutlets: BeritaPilkadaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        title = "Berita"
        
        _setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _fetchData()
    }
    
    private var _beritaItems: [BeritaItem] = []
    
    private let _beritaPilkadaService = BeritaPilkadaService(MOCKBeritaPilkadaNetworkManager())
    
    private func _fetchData() {
        _beritaPilkadaService.load(url: "") { [unowned self] (beritaItemList, error) in
            if let error = error {
                print(error)
            }
            
            if let beritaItems = beritaItemList?.items {
                DispatchQueue.main.async {
                    self._beritaItems = beritaItems
                    self.viewOutlets.tableView.reloadData()
                }
            }
        }
    }
    
    private func _setupTableView() {
        let tv = viewOutlets.tableView
        tv?.dataSource = self
        tv?.delegate = self
        tv?.rowHeight = 100
        
        let nib = UINib(nibName: "BeritaTableViewCell", bundle: nil)
        tv?.register(nib, forCellReuseIdentifier: "BeritaPilkadaCell")
    }
}

class BeritaPilkadaView: UIView {
    @IBOutlet weak var tableView: UITableView!
}

extension BeritaPilkadaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _beritaItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeritaPilkadaCell", for: indexPath) as! BeritaTableViewCell
        let berita = _beritaItems[indexPath.row]
        cell.titleLabel.text = berita.title
        cell.dateLabel.text = berita.date.toString(format: dateStringFormat)
        cell.descriptionLabel.text = berita.content
        return cell
    }
}

extension BeritaPilkadaViewController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController,
            let webViewController = destination.viewControllers.first as? WebViewController,
            let beritaItem = sender as? BeritaItem {
            webViewController.title = beritaItem.title
            webViewController.urlString = beritaItem.url
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = _beritaItems[indexPath.row]
        performSegue(withIdentifier: "WebViewController", sender: item)
    }
}
