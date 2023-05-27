//
//  LoginViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Temp Data
    let user = User.getTempData()
    var categories: [Category] = []
    var orders: [OrderData] = []
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - IBOutlets
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        fetchOrder()
    }
    
    // MARK: - IBActions
    @IBAction func loginBtnClick() {
        guard emailTF.text == user.email, passwordTF.text == user.password else {
            showAlert(
                title: "Неправильный логин или пароль",
                message: "Пожалуйста, укажите правильный лог/пароль",
                textField: passwordTF
            )
            return
        }
    }
    
    @IBAction func forgotBtnClick() {
        showAlert(title: "Ваш пароль ", message: user.password)
    }
    
    
    @IBAction func registerButtonClick() {
        
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? TabBarViewController else { return }
        tabBarVC.user = user
        tabBarVC.categories = categories
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

extension LoginViewController {
    private func fetchCategories() {
        networkManager.fetch(CategoryData.self, from: Link.category.url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.categories = data.data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchOrder() {
        networkManager.fetch(Order.self, from: Link.order.url) { [weak self] result in
            switch result {
            case .success(let order):
                self?.orders = order.data
            case .failure(let error):
                print(error)
            }
        }
    }
}
