//
//  Extensions.swift
//  eCommerce
//
//  Created by Weijie Lin on 4/12/19.
//  Copyright © 2019 Weijie Lin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension UIViewController {
    func handleFirebaseAuthError(error : Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
