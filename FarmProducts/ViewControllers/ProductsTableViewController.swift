//
//  ProductsTableViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

class ProductsTableViewController: UITableViewController {

    // MARK: - Public properties
    var products: [Product]!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed)
        )
        
        navigationItem.rightBarButtonItem = addButton

    }
    
    @objc func addButtonPressed() {
        present(AddProductViewController(), animated: true)
    }

    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        guard let detailsVC = segue.destination as? ProductsDetailViewController else  {
            return
        }
        
        detailsVC.product = products[indexPath.row]
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

        let product = products[indexPath.row]
        print(product.name)

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            print("Delete action")
        }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, isDone in
            print("Edit action")
            isDone(true)
        }

        let doneAction = UIContextualAction(style: .normal, title: "Done") { _, _, isDone in
            print("Done action")
            isDone(true)
        }

        editAction.backgroundColor = .orange
        doneAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction])
    }
}
