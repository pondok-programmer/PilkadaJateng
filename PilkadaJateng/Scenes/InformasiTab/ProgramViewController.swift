//
//  ProgramViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/16/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class ProgramTableViewController: UITableViewController {
    @IBAction func selesaiButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ProgramTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProgramCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var data: [String] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell", for: indexPath) as! ProgramTableViewCell
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.contentLabel.text = "\(data[indexPath.row])"
        return cell
    }
}


