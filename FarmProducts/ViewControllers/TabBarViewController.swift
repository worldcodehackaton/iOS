//
//  TabBarViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Public properties
    var user: User!
    
    var categories: [Category] = []
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.email)
        transferData()
    }
    
    // MARK: - Prepare with screens
    private func transferData() {
        guard let viewControllers else { return }
        fetchCategories()
        
        viewControllers.forEach { viewController in
            if let navigationVC = viewController as? UINavigationController {
                let categoriesVC = navigationVC.topViewController
                if let categoriesVC = categoriesVC as? CategoryCollectionViewController {
                    categoriesVC.user = user
                } else if let categoriesVC = categoriesVC as? OrdersTableViewController {
                    categoriesVC.orders = Order.getOrder()
                }
            }
        }
    }
    
    // MARK: - Fetch func 
    private func fetchCategories() {
        networkManager.fetch([Category].self, from: Link.category.url) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.categories = data
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
