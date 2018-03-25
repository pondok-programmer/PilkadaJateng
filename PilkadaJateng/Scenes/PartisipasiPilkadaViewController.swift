//
//  PartisipasiPilkadaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class PartisipasiPilkadaViewController: UIViewController {
    @IBOutlet weak var viewOutlets: PartisipasiPilkadaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let nib = UINib(nibName: "PartisipasiPilkadaCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "PartisipasiPilkadaCell")
        cv?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    private var _data: [PartisipasiPilkada] = []
    private let service = InformasiPilkadaService<PartisipasiPilkada>(networkManager: MOCKNetworkManager())
    
    private func _fetchData() {
        service.getData(url: InformasiPilkadaType.partisipasi.getUrl()) { [unowned self] (data, error) in
            if let error = error {
                fatalError()
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self._data = data
                    self.viewOutlets.collectionView.reloadData()
                }
            }
        }
    }
}

class PartisipasiPilkadaView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension PartisipasiPilkadaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartisipasiPilkadaCell", for: indexPath) as? PartisipasiPilkadaCollectionViewCell
        cell?.textLabel.text = _data[indexPath.row].namaKabupatenKota
        return cell!
    }
}
