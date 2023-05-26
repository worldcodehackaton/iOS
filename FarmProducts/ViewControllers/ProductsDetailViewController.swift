//
//  ProductsDetailViewController.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

class ProductsDetailViewController: UIViewController {

    // MARK: - Public properties
    var product: Product!
    
    // MARK: - IB Outlets
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet var detailsLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "fish")
        detailsLabel.text = product.details
    }
}
