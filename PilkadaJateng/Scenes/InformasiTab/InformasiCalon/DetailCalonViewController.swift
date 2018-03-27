//
//  DetailCalonViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/26/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

enum DetailCalon {
    case visiMisi([VisiMisiCalon])
    case prioritasProgram([PrioritasProgramCalon])
    case programUnggulan([ProgramUnggulanCalon])
    case lhkpn([LHKPN])
}

class DetailCalonViewController: UIViewController {
    @IBOutlet weak var viewOutlets: DetailCalonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _fetchData()
    }
    
    private func _setupCollectionView() {
        let cv = viewOutlets.collectionView
        let visiMisiCell = UINib(nibName: "VisiMisiCalonCollectionViewCell",
                                 bundle: nil)
        let programUnggulanCell = UINib(nibName: "ProgramUnggulanCalonCollectionViewCell",
                                        bundle: nil)
        let prioritasProgramCell = UINib(nibName: "PrioritasProgramCalonCollectionViewCell",
                                         bundle: nil)
        let lhkpnCell = UINib(nibName: "LHKPNCollectionViewCell",
                              bundle: nil)
        
        cv?.register(visiMisiCell, forCellWithReuseIdentifier: "VisiMisiCell")
        cv?.register(programUnggulanCell, forCellWithReuseIdentifier: "ProgramUnggulanCell")
        cv?.register(prioritasProgramCell, forCellWithReuseIdentifier: "PrioritasProgramCell")
        cv?.register(lhkpnCell, forCellWithReuseIdentifier: "LHKPNCell")
        
        cv?.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        cv?.collectionViewLayout = layout
    }
    
    var isPetahana: Bool = false
    
    private var _detail: [DetailCalon] {
        if isPetahana {
            return [.visiMisi([]), .programUnggulan([]), .lhkpn([])]
        } else {
            return [.visiMisi([]), .prioritasProgram([])]
        }
    }
    
    private var _data: [DetailCalon] = []
    
    private func _fetchData() {
        let v = MockProvider.shared.makeVisiMisi()
        let pu = MockProvider.shared.makeProgramUnggulan()
        let pp = MockProvider.shared.makePrioritasProgram()
        let l = MockProvider.shared.makeLHKPN()
        
        
        
        _data = _detail.map({ (d) -> DetailCalon in
            switch d {
            case .visiMisi(_): return .visiMisi(v)
            case .programUnggulan(_): return .programUnggulan(pu)
            case .prioritasProgram(_): return .prioritasProgram(pp)
            case .lhkpn(_): return .lhkpn(l)
            }
        })
        viewOutlets.collectionView.reloadData()
    }
}

class DetailCalonView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
}

extension DetailCalonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data.count
    }
    
    private func getIdentifier(_ indexPath: IndexPath) -> String {
        switch _data[indexPath.row] {
        case .visiMisi(_):
            return "VisiMisiCell"
        case .programUnggulan(_):
            return "ProgramUnggulanCell"
        case .prioritasProgram(_):
            return "PrioritasProgramCell"
        case .lhkpn(_):
            return "LHKPNCell"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = getIdentifier(indexPath)
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: identifier,for: indexPath)
        
        switch cell {
        case is VisiMisiCalonCollectionViewCell:
            let c = cell as! VisiMisiCalonCollectionViewCell
            c.textLabel.text = "VisiMisi"
        case is ProgramUnggulanCalonCollectionViewCell:
            let c = cell as! ProgramUnggulanCalonCollectionViewCell
            c.textLabel.text = "ProgramUnggulan"
        case is PrioritasProgramCalonCollectionViewCell:
            let c = cell as! PrioritasProgramCalonCollectionViewCell
            c.textLabel.text = "PrioritasProgram"
        case is LHKPNCollectionViewCell:
            let c = cell as! LHKPNCollectionViewCell
            c.textLabel.text = "LHKPN"
        default:
            fatalError("Check")
        }
        return cell
    }
}
