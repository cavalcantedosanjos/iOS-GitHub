//
//  FavoriteTableViewCell.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/7/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    func setup(with repo: Repository) {
        nameLabel.text = repo.name
        languageLabel.text = repo.language
    }

}
