//
//  UserTableViewCell.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

   
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(with user: User) {
        nameLabel.text = user.login
        
        if let urlString = user.avatar_url {
            logoImageView.loadImage(urlString: urlString)
        }
        
    }
}
