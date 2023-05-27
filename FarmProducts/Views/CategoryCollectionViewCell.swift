//
//  CategoryCollectionViewCell.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView! {
        didSet {
            categoryImageView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    func configure(with category: CategoryData) {
        categoryImageView.image = UIImage(named: "vegetables")
        categoryNameLabel.text = "Empty"
    }
    
}
