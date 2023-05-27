//
//  CategoriesTableViewController.swift
//  FarmProducts
//
//  Created by Khusain on 27.05.2023.
//

import UIKit

final class CategoriesTableViewController: UITableViewController {

    var user: User!
    var categories: [Category] = []
    var products: [Product] = []
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.toolbar.backgroundColor = .black
        fetchProducts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        
        guard let cell = cell as? CategoryTableViewCell else { return UITableViewCell() }

        cell.nameLabel.text = categories[indexPath.row].name
        cell.descriptionLabel.text = categories[indexPath.row].description

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productsVC = segue.destination as? ProductsTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        productsVC.categoryId = categories[indexPath.row].id
        productsVC.storeId = user.id
        productsVC.products = products.filter({
            $0.category_id == categories[indexPath.row].id && $0.store_id == user.id
        })
    }
    
    func fetchProducts() {
        networkManager.fetch(ProductData.self, from: Link.product.url) { [weak self] result in
            switch result {
            case .success(let productData):
                self?.products = productData.data
            case .failure(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

//        let category = categories[indexPath.row]

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            self?.categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, isDone in
            self?.showAlert(title: "Изменение категории", message: "", indexPath: indexPath)
            isDone(true)
        }

        editAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func showAlert(title: String, message: String, indexPath: IndexPath) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] in
            $0.placeholder = "Введите название"
            $0.text = self?.categories[indexPath.row].name
        }
        
        alertController.addTextField { [weak self] in
            $0.placeholder = "Введите описание"
            $0.text = self?.categories[indexPath.row].description
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            if let name = alertController.textFields?.first?.text, let description = alertController.textFields?.last?.text {
                self?.categories[indexPath.row].name = name
                self?.categories[indexPath.row].description = description
                self?.tableView.reloadData()
            }
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        
        present(alertController, animated: true, completion: nil)

        
    }

}

extension UITableViewController {
    
}
