//
//  TipsViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    @IBOutlet weak var viewOutlets: TipsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let nib = UINib(nibName: "TipsCollectionViewCell", bundle: nil)
        cv?.register(nib, forCellWithReuseIdentifier: "TipsCell")
        cv?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    private var _data: [String] = []
    private func _fetchData() {
        
    }
}

class TipsView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension TipsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipsCell", for: indexPath) as? TipsCollectionViewCell
        return cell!
    }
}
