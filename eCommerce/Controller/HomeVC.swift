//
//  ViewController.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/7/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    //Outlets
    @IBOutlet weak var loginButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var categories = [Category]()
    var selectedCategory: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sampleCategory = Category.init(name: "Mountain", id: "photo-1555999005-20c8ca7cc584", imgUrl: "https://images.unsplash.com/photo-1555999005-20c8ca7cc584?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", isActive: true, timeStamp: Timestamp())
        let sampleCategory2 = Category.init(name: "Person", id: "photo-1555783242-da78a8b3c8e0", imgUrl: "https://images.unsplash.com/photo-1555783242-da78a8b3c8e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", isActive: true, timeStamp: Timestamp())
        categories.append(sampleCategory)
        categories.append(sampleCategory2)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error)
                    self.handleError(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            // to log out
            loginButton.title = "Logout"
        }
        else {
            // to log in
            loginButton.title = "Login"
        }
    }
    
    fileprivate func presentLogin() {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            // to log out
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        debugPrint(error)
                        self.handleError(errorMessage: error.localizedDescription)
                        return
                    }
                    self.presentLogin()
                }
            }
            catch {
                debugPrint(error)
                self.handleError(errorMessage: error.localizedDescription)
            }
            
        }
        else {
            // to log in
            presentLogin()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 50) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: "toProductsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductsVC" {
            if let destination = segue.destination as? ProductsVC {
                destination.category = selectedCategory
            }
        }
    }
}
