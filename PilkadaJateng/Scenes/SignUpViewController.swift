//
//  SignUpViewController.swift
//  PilkadaJateng
//
//  Created by PondokiOS on 4/20/18.
//  Copyright © 2018 PondokiOS. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUp() {
        let displayName = displayNameTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        authService.createUser(displayName: displayName, username: username, password: password) { [unowned self](user, error) in
            if let user = user {
                self.showAlert(title: "Akun \(user.name) berhasil dibuat", message: "Tekan OK untuk Masuk")
            }
            
            if let error = error {
                print(error)
                self.showAlert(title: "Gagal membuat akun", message: "Tekan OK untuk kembali ke layar Masuk")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let authService = AuthService()
    
    
    func showAlert(title: String?, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { [unowned self](_) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        alertVC.addAction(cancel)
        alertVC.addAction(ok)
        present(alertVC, animated: true, completion: nil)
    }
}
