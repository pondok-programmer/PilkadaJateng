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
    /// Call viewWillAppear
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
    
    func showError(title: String?, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    /// To Discussion with path title
    @IBAction func toChatDiscussion() {
        let refPath = title.orFatalError(alsoIf: "").removeChar([".", "#", "$", "[", "]"])
        let cVC = ChatViewController(nibName: "ChatViewController", bundle: nil)
        cVC.chatService = ChatService(channelRef: FirebaseRefMake(withPath: refPath))
        cVC.title = "Diskusi \"\(refPath)\""
        show(cVC, sender: nil)
    }
    
    func plainNavigationBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
