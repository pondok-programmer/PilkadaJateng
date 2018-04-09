//
//  TahapanPilkadaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class TahapanPilkadaViewController: UIViewController {
    @IBOutlet weak var viewOutlets: TahapanPilkadaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let nib = UINib(nibName: "TahapanPilkadaCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "TahapanPilkadaCell")
        cv?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    private var _data: [TahapanPilkada] = []
    private let service = InformasiService<TahapanPilkada>(networkManager: MockProvider.shared.makeTahapanNetworkMock())
    
    private func _fetchData() {
        service.getData(url: InformasiType.tahapan.getUrl()) { [unowned self] (data, error) in
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

class TahapanPilkadaView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension TahapanPilkadaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TahapanPilkadaCell", for: indexPath) as? TahapanPilkadaCollectionViewCell
        cell?.textLabel.text = "\(_data[indexPath.row].tahapan)"
        return cell!
    }
}


