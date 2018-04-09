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
        tableView.delegate = self
        
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
        
        let data = self.data[indexPath.section].sorted(by: { $0.awal < $1.awal } )[indexPath.row]
        cell.timelinePoint = TimelinePoint()
        
        var frontColor: UIColor {
            let isFirstItem = indexPath.row == 0
            let isBeforeCurrentDate = Date() > data.awal
            
            guard !isFirstItem else {
                return .clear
            }
            
            if isBeforeCurrentDate {
                return .black
            }
            
            return .red
        }
        
        cell.timeline.frontColor = frontColor
        
        var backColor: UIColor {
            let isLastItem = indexPath.row >= self.data[indexPath.section].count - 1
            let isBeforeCurrentDate = Date() > data.awal
            
            guard !isLastItem else {
                return .clear
            }
            
            if isBeforeCurrentDate {
                return .black
            }
            
            return .red
        }
        cell.timeline.backColor = backColor
        
        cell.titleLabel.text = "\(data.awal.toString(format: "dd MMM yyyy")) sampai \(data.akhir.toString(format: "dd MMM yyyy"))"
        cell.descriptionLabel.text = data.detail
        let day = dateDiff(firstDate: Date(), secondDate: data.akhir)
        cell.lineInfoLabel.text = "\(day < 0 ? 0 : day ) hari tersisa"
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

extension PJTahapanPilkadaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Persiapan" : "Penyelenggaraan"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
