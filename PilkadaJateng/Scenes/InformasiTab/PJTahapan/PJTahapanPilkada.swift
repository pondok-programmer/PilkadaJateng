//
//  TahapanPilkada.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/9/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import TimelineTableViewCell

class PJTahapanPilkadaViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupTableView()
    }
    
    var data: [[TahapanPilkada]] = []
    
    private let _service = InformasiTahapanService(networkManager: MOCKTahapan())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _service.getData { [unowned self] (data, error) in
            if let data = data {
                self.data = data
                self.tableView.reloadData()
            }
        }
    }
    
    private func _setupTableView() {
        tableView.dataSource = self
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
                                             bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TahapanCell")
    }
}

extension PJTahapanPilkadaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TahapanCell", for: indexPath) as! TimelineTableViewCell
        
        let data = self.data[indexPath.section][indexPath.row]
        cell.timelinePoint = TimelinePoint()
        cell.timeline.frontColor = .red
        cell.timeline.backColor = .black
        cell.titleLabel.text = "\(data.awal.toString(format: "dd MMM yyyy")) sampai \(data.akhir.toString(format: "dd MMM yyyy"))"
        cell.descriptionLabel.text = data.detail
        cell.lineInfoLabel.text = "\(dateDiff(firstDate: data.awal, secondDate: data.akhir)) hari"
        return cell
    }
    
    func dateDiff(firstDate: Date, secondDate: Date) -> Int {
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
}
