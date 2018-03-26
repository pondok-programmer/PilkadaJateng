//
//  InformasiCalonViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class InformasiCalonViewController: UIViewController {
    @IBOutlet weak var viewOutlets: InformasiCalonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let nib = UINib(nibName: "InformasiCalonCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "InformasiCalonCell")
        cv?.dataSource = self
        cv?.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    private var _data: [ProfilCalon] = []
    private let service = InformasiService<ProfilCalon>(networkManager: MockProvider.shared.makeProfilCalonNetworkMock())
    
    private func _fetchData() {
        service.getData(url: InformasiType.profilCalon.getUrl()) { [unowned self] (data, error) in
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
    
    private var _isSelectedStatusPetahana = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailCalonViewController {
            destination.isPetahana = _isSelectedStatusPetahana
        }
        
    }
}

class InformasiCalonView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension InformasiCalonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InformasiCalonCell", for: indexPath) as? InformasiCalonCollectionViewCell
        cell?.textLabel.text = "\(_data[indexPath.row].namaKepalaDaerah)"
        return cell!
    }
}

extension InformasiCalonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _isSelectedStatusPetahana = _data[indexPath.row].isPetahana
        performSegue(withIdentifier: "DetailCalonViewController", sender: nil)
    }
}


