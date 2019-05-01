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
    var db: Firestore!
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
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
    
    func fetchCollection() {
        let collectionRef = db.collection("categories")
        
        listener = collectionRef.addSnapshotListener { (snap, error) in
            self.categories.removeAll()
            guard let documents = snap?.documents else {return}
            for document in documents {
                let newCategory = Category.init(data: document.data())
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        }
        
//        collectionRef.getDocuments { (snap, error) in
//            guard let documents = snap?.documents else {return}
//            for document in documents {
//                let newCategory = Category.init(data: document.data())
//                self.categories.append(newCategory)
//            }
//            self.collectionView.reloadData()
//        }
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
        
        fetchCollection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
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
        let cellWidth = (view.frame.width - 30) / 2
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
