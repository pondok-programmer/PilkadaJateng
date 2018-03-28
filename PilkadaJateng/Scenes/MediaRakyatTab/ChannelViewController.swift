//
//  ChannelViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/28/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChannelViewController: UIViewController {
    @IBAction func goToChat(_ sender: UIButton) {
        let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
}

extension ChannelViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Channel Diskusi")
    }
}
