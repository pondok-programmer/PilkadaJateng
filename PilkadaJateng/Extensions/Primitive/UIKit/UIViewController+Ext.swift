//
//  UIViewController+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/5/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Set title when current VC under TabBarController. TabBarController is under NavigationController
    func setTitle(_ title: String) {
        tabBarController?.title = title
    }
    
    /// Show ViewController from TabBarController
    func showFromTabBarController(_ vc: UIViewController) {
        tabBarController?.show(vc, sender: nil)
    }
    
    /// Since VC is loaded once, then call this method inside viewWillAppear
    func setupTabBarControllerNavigationItem(completion: @escaping (UINavigationItem?) -> ()) {
        let navItem = tabBarController?.navigationItem
        completion(navItem)
    }
}
