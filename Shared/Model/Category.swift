//
//  Category.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/21/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imgUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
}
