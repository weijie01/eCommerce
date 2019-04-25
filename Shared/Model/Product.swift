//
//  Product.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/24/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name: String
    var id: String
    var category: String
    var price: Double
    var productDescription: String
    var imageUrl: String
    var timeStamp: Timestamp
    var stock: Int
    var isFavorite: Bool
    
}
