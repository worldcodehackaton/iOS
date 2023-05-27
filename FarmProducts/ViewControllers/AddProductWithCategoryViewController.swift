//
//  AddProductViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

final class AddProductWithCategoryViewController: UIViewController {

    weak var delegate: DataDelegate?
    
    var categoryId: Int!
    var storeId: Int!
    
    private let networkManager = NetworkManager.shared
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    
    @IBOutlet var calcTypeSC: UISegmentedControl!
    
    @IBAction func addProductButton() {
        let price = priceTF.text ?? ""
        let calcType = calcTypeSC.selectedSegmentIndex == 0 ? "WHOLESAIL" : "RETAIL"
        
        let product = Product(
            id: 201,
            name: nameTF.text ?? "",
            price: price,
            description: descriptionTF.text ?? "",
            store_id: storeId,
            category_id: categoryId ?? 0,
            calc_type: calcType
        )
        
        let productAdapter = ProductAdapter(from: product)
        
        networkManager.sendPostRequest(to: Link.product.post, with: productAdapter)
        
        
        delegate?.sendProduct(product)
        dismiss(animated: true)
    }
    

}
