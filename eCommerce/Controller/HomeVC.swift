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

    @IBOutlet weak var loginButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

