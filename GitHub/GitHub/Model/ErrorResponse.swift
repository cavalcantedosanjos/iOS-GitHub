//
//  ServiceError.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/4/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var message: String?
    var documentation_url: String?
}
