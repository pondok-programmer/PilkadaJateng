//
//  ViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit
import PKHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var viewOutlets: LoginView!

    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupLoginAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func _setupLoginAction() {
        let loginButton = viewOutlets.loginButton
        loginButton?.addTarget(self, action: .loginAction, for: .touchUpInside)
    }
    
    @objc func loginAction() {
        HUD.show(.labeledProgress(title: nil, subtitle: nil))
//        let username = viewOutlets.usernameTextField.text ?? ""
//        let password = viewOutlets.passwordTextField.text ?? ""
        
        let username = "m@k.com"
        let password = "halohalo@"
        
        authService.login(username: username, password: password) { [unowned self] (user, error) in
            HUD.hide()
            if let error = error {
                self.showAlert(title: error.localizedDescription)
            }
            
            if let user = user {
                Application.shared.user = user
                self._goToMainViewController(with: user)
            }
        }
    }
    
    func showAlert(title: String?, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func _goToMainViewController(with user: User) {
        performSegue(withIdentifier: "MainViewController", sender: self)
    }
}

fileprivate extension Selector {
    static let loginAction = #selector(LoginViewController.loginAction)
}


class LoginView: UIView {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
}
