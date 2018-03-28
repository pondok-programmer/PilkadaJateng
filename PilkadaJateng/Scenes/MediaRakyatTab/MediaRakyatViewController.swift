//
//  MediaRakyatViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/27/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import XLPagerTabStrip

typealias MediaRakyatViewController = MediaRakyatPagerTabStrip

class MediaRakyatPagerTabStrip: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .red
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarHeight = 20 + 44
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [ChannelListViewController(nibName: "ChannelListViewController", bundle: nil),
                TimelineViewController(nibName: "TimelineViewController", bundle: nil)]
    }
}


