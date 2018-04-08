//
//  User.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/4/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var id: Int?
    var login: String?
    var avatar_url: String?
    var repos_url: String?
    var score: Double?
    
}
