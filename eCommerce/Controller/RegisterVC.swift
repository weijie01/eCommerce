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
    @IBOutlet weak var confirmPasswordCheckImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordText.addTarget(self, action: #selector(textFieldChanged(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordText.addTarget(self, action: #selector(textFieldChanged(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        guard let password = passwordText.text else {return}
        if textField == passwordText {
            if password.isEmpty {
                confirmPasswordText.text = ""
                confirmPasswordCheckImage.isHidden = true
            }
        }
        else if textField == confirmPasswordText {
            confirmPasswordCheckImage.isHidden = false
        }
        
        if passwordText.text == confirmPasswordText.text {
            confirmPasswordCheckImage.image = UIImage(named: "green_check")
        }
        else {
            confirmPasswordCheckImage.image = UIImage(named: "red_check")
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let username = usernameText.text, username.isNotEmpty, let email = emailText.text, email.isNotEmpty, let password = passwordText.text, password.isNotEmpty else {return}
        
        activityIndicator.startAnimating()
        
        guard let user = Auth.auth().currentUser else {return}
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        user.linkAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                debugPrint(error)
                self.activityIndicator.stopAnimating()
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
