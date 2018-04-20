//
//  WacanaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class WacanaViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTableView()
        _fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBarControllerNavigationItem { (navItem) in
            navItem?.rightBarButtonItem = nil
        }
    }
    
    func _setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TipsCell")
    }
    
    private var _data: [MateriWacana] = []
    
    private let _networkManager = MOCKMateriWancanaNetworkManager()
    private lazy var _wacanaService = WacanaService(networkManager: self._networkManager)
    
    private func _fetchData() {
        _wacanaService.getData(url: "http://g.com/") { [unowned self] (data, error) in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self._data = data
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController {
            if let vc = nav.viewControllers.first as? TambahTipsViewController {
                vc.delegate = self
            } else if let vc = nav.viewControllers.first as? RingkasanWacanaViewController {
                vc.materiWacana = sender as! MateriWacana
            }
        }
    }
}

extension WacanaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsCell", for: indexPath)
        cell.textLabel?.text = _data[indexPath.row].judul
        return cell
    }
}

extension WacanaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "RingkasanWacanaViewController", sender: _data[indexPath.row])
    }
}

extension WacanaViewController: _TambahTipsDelegateViewController {
    func finish(_ materiWacana: MateriWacana) {
        _data.append(materiWacana)
        tableView.reloadData()
    }
}
