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
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        id = data["id"] as? String ?? ""
        imgUrl = data["imgUrl"] as? String ?? ""
        isActive = data["isActive"] as? Bool ?? true
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}
