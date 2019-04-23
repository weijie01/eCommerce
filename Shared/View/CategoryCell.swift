//
//  CategoryCell.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/22/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 5
    }
    
    func configureCell(category: Category) {
        categoryLabel.text = category.name
        if let url = URL(string: category.imgUrl) {
            categoryImage.kf.setImage(with: url)
        }
    }
}
