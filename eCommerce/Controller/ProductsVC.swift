//
//  ProductsVC.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/24/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var products = [Product]()
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sampleProduct = Product.init(name: "mountain", id: "1", category: "Mountain", price: 24.99, productDescription: "What a lovely mountain.", imageUrl: "https://images.unsplash.com/photo-1555999005-20c8ca7cc584?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", timeStamp: Timestamp(), stock: 1, isFavorite: false)
        let sampleProduct2 = Product.init(name: "mountain", id: "1", category: "Mountain", price: 24.99, productDescription: "What a lovely mountain.", imageUrl: "https://images.unsplash.com/photo-1555999005-20c8ca7cc584?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", timeStamp: Timestamp(), stock: 1, isFavorite: false)
        products.append(sampleProduct)
        products.append(sampleProduct2)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
}

extension ProductsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
