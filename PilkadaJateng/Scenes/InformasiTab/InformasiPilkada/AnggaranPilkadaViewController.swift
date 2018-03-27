//
//  AnggaranPilkadaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class AnggaranPilkadaViewController: UIViewController {
    @IBOutlet weak var viewOutlets: AnggaranPilkadaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let nib = UINib(nibName: "AnggaranPilkadaCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "AnggaranPilkadaCell")
        cv?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    private var _data: [AnggaranPilkada] = []
    private let service = InformasiService<AnggaranPilkada>(networkManager: MockProvider.shared.makeAnggaranNetworkMock())
    
    private func _fetchData() {
        service.getData(url: InformasiType.anggaran.getUrl()) { [unowned self] (data, error) in
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

class AnggaranPilkadaView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension AnggaranPilkadaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnggaranPilkadaCell", for: indexPath) as? AnggaranPilkadaCollectionViewCell
        cell?.textLabel.text = "\(_data[indexPath.row].jumlahAnggaran)"
        return cell!
    }
}

