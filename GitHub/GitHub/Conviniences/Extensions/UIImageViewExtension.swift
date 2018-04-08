//
//  UIImageViewExtension.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

import UIKit
import Kingfisher


extension UIImageView {
    
    func loadImage(urlString: String) {
        
        let url = URL(string: urlString)
        
        self.kf.setImage(with: url, options: []) { (image, error, type, url) in
            if error == nil && image != nil {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "ic_image_galery")
                }
            }
        }
    }
}
