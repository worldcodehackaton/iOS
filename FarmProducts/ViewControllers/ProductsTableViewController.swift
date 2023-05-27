//
//  ProductsTableViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

protocol DataDelegate: AnyObject {
    func sendProduct(_ product: Product)
}

final class ProductsTableViewController: UITableViewController {

    // MARK: - Public properties
    var storeId: Int!
    var categoryId: Int!
    var products: [Product] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow, let detailsVC = segue.destination as? ProductsDetailViewController {
            
            detailsVC.product = products[indexPath.row]
        } else if let addVC = segue.destination as? AddProductWithCategoryViewController {
            addVC.categoryId = categoryId
            addVC.storeId = storeId
            addVC.delegate = self
        }
    }

}

// MARK: - Table view data source
extension ProductsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
        
        guard let cell = cell as? ProductTableViewCell else { return UITableViewCell() }
        
        let product = products[indexPath.row]
        cell.configure(product: product)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            self?.products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, isDone in
            self?.showAlert(title: "Изменение продукта", message: "", indexPath: indexPath)
            isDone(true)
        }

        editAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
}

extension ProductsTableViewController: DataDelegate {
    func sendProduct(_ product: Product) {
        products.append(product)
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String, indexPath: IndexPath) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { [weak self] in
            $0.placeholder = "Введите название"
            $0.text = self?.products[indexPath.row].name
        }
        
        alertController.addTextField { [weak self] in
            $0.placeholder = "Введите описание"
            $0.text = self?.products[indexPath.row].description
        }
        
        alertController.addTextField { [weak self] in
            $0.placeholder = "Введите новую цену"
            $0.text = self?.products[indexPath.row].price
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(title: "Ок", style: .default) { [weak self] _ in
            if let name = alertController.textFields?[0].text, let description = alertController.textFields?[1].text, let price = alertController.textFields?[2].text {
                self?.products[indexPath.row].name = name
                self?.products[indexPath.row].description = description
                self?.products[indexPath.row].price = price
                
                self?.tableView.reloadData()
            }
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        
        present(alertController, animated: true, completion: nil)

        
    }
    
}
