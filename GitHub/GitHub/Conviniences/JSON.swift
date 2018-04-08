//
//  JSON.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

class JSON {
    
    static func decode<T: Codable>(data: Data) -> T? {
        var object: T?
        do {
            object =  try JSONDecoder().decode(T.self, from: data)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            print(userInfo)
        }
        
        return object
    }
    
}
