//
//  ProductCell.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/24/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: RoundedImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(product: Product) {
        productNameLabel.text = product.name
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
    }
    
}
