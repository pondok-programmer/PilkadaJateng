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
        tabBar.tintColor = UIColor(red: 255/255, green: 86/255, blue: 97/255, alpha: 1)
    }
    
    let authService = AuthService()
    
    @IBAction func signOut() {
        signOutAlert()
    }
    
    func signOutAlert() {
        let alertVC = UIAlertController(title: "Keluar", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Ya", style: .default, handler: {[unowned self](_)->() in
            do {
                try self.authService.signOut()
                self.dismiss(animated: true, completion: nil)
            } catch let e {
                self.showAlert(title: e.localizedDescription)
            }
        })
        alertVC.addAction(cancel)
        alertVC.addAction(ok)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
}
