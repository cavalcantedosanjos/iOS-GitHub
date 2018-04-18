//
//  SearchUserResponse.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

struct SearchUserResponse: Codable {
    
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [User]?
}
