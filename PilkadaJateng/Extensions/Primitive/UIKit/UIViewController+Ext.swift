//
//  UIViewController+Ext.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/5/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time

        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }

        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)

        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)

        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
        
        print(frame!)
    }
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
}
