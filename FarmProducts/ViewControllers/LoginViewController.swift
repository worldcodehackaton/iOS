//
//  LoginViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Temp Data

    let user = User.getTempData()
    
    // MARK: - IBOutlets
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    // MARK: - IBActions
    @IBAction func loginBtnClick() {
        guard emailTF.text == user.email, passwordTF.text == user.password else {
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login or password",
                textField: passwordTF
            )
            return
        }
    }
    
    @IBAction func forgotBtnClick() {
        showAlert(title: "Your Password", message: user.password)
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? TabBarViewController else { return }
        tabBarVC.user = user
    }
    
}

// MARK: - Show Alert
extension LoginViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertOkAction = UIAlertAction(title: "Ok", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(alertOkAction)
        present(alert, animated: true)
    }
}
