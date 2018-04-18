//
//  MainTabBarController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/9/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        tabBar.isTranslucent = false
        
        let nav = navigationController!
        
        let image = UIImage(named: "pilwara")!
        let imageView = UIImageView(image:image)
        
        let bannerWidth = nav.navigationBar.frame.size.width
        let bannerHeight = nav.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x:bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
    }
}
