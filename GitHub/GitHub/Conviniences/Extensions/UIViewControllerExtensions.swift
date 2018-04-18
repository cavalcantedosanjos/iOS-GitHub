//
//  UIViewControllerExtensions.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    
    func showAlert(title: String, message: String, buttonTitle: String, dissmisBlock: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonTitle, style: .default) { (alertAction) in
            dissmisBlock()
        }
        
        alertController.addAction(button)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func startLoading() {
        HUD.show(.progress)
    }
    
    func stopLoading() {
        HUD.hide()
    }
    
}
