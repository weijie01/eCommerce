//
//  RegisterVC.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/11/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let username = usernameText.text, !username.isEmpty, let email = emailText.text, !email.isEmpty, let password = passwordText.text, !password.isEmpty else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // ...
            if let error = error {
                debugPrint(error)
                return
            }
            
            print("Success")
        }
    }
    
    
}
