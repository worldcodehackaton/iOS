//
//  TabBarViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Public properties
    var user: User!
    
    var categories: [Category]!
    var orders: [OrderData] = []
    
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
        
        viewControllers.forEach { viewController in
            if let navigationVC = viewController as? UINavigationController {
                let categoriesVC = navigationVC.topViewController
                if let categoriesVC = categoriesVC as? CategoriesTableViewController {
                    categoriesVC.categories = categories
                    categoriesVC.user = user
                } else if let categoriesVC = categoriesVC as? OrdersTableViewController {
                    print("Im here")
//                    print(orders)
                    categoriesVC.orders = orders
                }
            } else if let addProductVC = viewController as? AddProductViewController {
                addProductVC.storeId = user.id
                addProductVC.categories = categories
            }
        }
    }
    
    // MARK: - Fetch func 

    
}
