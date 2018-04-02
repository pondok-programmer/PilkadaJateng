//
//  WacanaViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class WacanaViewController: UIViewController {
    @IBOutlet weak var viewOutlets: WacanaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let nib = UINib(nibName: "WacanaCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "WacanaCell")
        cv?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    private var _data: [String] = []
    private func _fetchData() {
        
    }
}

class WacanaView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension WacanaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WacanaCell", for: indexPath) as? WacanaCollectionViewCell
        return cell!
    }
}
