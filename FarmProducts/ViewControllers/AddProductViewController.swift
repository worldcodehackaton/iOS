//
//  AddProductViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

final class AddProductViewController: UIViewController {
    
    var categories: [Category] = []
    var storeId: Int!
    
    private var selected = 0
    
    private let networkManager = NetworkManager.shared
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    @IBOutlet var categoryPickerView: UIPickerView!
    
    @IBOutlet var calcTypeSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
    }
    
    @IBAction func addProductButton() {
        let price = priceTF.text ?? ""
        let calcType = calcTypeSC.selectedSegmentIndex == 0 ? "WHOLESAIL" : "RETAIL"
        
        let product = Product(
            id: 201,
            name: nameTF.text ?? "",
            price: price,
            description: descriptionTF.text ?? "",
            store_id: storeId,
            category_id: selected,
            calc_type: calcType
        )
        
        let productAdapter = ProductAdapter(from: product)
        
        networkManager.sendPostRequest(to: Link.product.post, with: productAdapter)
        
        nameTF.text = ""
        descriptionTF.text = ""
        priceTF.text = ""
        
        showTaskCompleteMessage()
    }
    
}

extension AddProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
}

extension AddProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = categories[row].id
    }
}

extension AddProductViewController {
    private func showTaskCompleteMessage() {
        let alertController = UIAlertController(title: nil, message: "Новый продукт добавлен", preferredStyle: .actionSheet)
        
        present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
