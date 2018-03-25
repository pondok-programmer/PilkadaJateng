//
//  ViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 3/25/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

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
        let username = viewOutlets.usernameTextField.text ?? ""
        let password = viewOutlets.passwordTextField.text ?? ""
        
        authService.login(username: username, password: password) { [unowned self] (user, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            if let user = user {
                self._goToMainViewController(with: user)
            }
        }
    }
    
    private func _goToMainViewController(with user: User) {
        Application.shared.user = user
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
