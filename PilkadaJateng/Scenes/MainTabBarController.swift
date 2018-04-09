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
    }
}
