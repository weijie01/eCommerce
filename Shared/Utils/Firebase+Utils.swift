//
//  Firebase+Utils.swift
//  eCommerce
//
//  Created by Weijie Lin on 5/3/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import Foundation
import Firebase

extension Firestore {
    var categories : Query {
        return collection("categories").order(by: "timeStamp", descending: true)
    }
    
    func products(category : String) -> Query {
        return collection("products").whereField("category", isEqualTo: category) .order(by: "timeStamp", descending: true)
    }
}
