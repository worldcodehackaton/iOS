//
//  ProductTableViewCell.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView! {
        didSet {
            productImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func configure(product: Product) {
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = product.priceDescription
        
        productImageView.image = UIImage(named: "zlak")
    }

}
