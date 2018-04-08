//
//  Repository.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/4/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import CoreData.NSEntityDescription
import CoreData.NSManagedObjectContext

struct Repository: Codable {

    var id: Int?
    var name: String?
    var full_name: String?
    var language: String?
    var description: String?
    var forks_count: Int?
    var stargazers_count: Int?
    
    var owner: User?
    
    var isFavorite: Bool?
    
    func toManagedObject(entity: NSEntityDescription, insertInto: NSManagedObjectContext) -> NSManagedObject {
        let newRepo = NSManagedObject(entity: entity, insertInto: insertInto)
        
        newRepo.setValue(self.id ?? 0, forKey: "id")
        newRepo.setValue(self.name ?? "", forKey: "name")
        newRepo.setValue(self.language ?? "", forKey: "language")
        newRepo.setValue(self.full_name ?? "", forKey: "full_name")
        newRepo.setValue(self.description ?? "", forKey: "desc")
        newRepo.setValue(self.forks_count ?? 0, forKey: "forks_count")
        newRepo.setValue(self.stargazers_count ?? 0, forKey: "stargazers_count")
        newRepo.setValue(self.owner?.login ?? "", forKey: "owner")
        
        return newRepo
    }
    
    init(from managedObject: NSManagedObject, isFavorite: Bool) {

        self.id = managedObject.value(forKey: "id") as? Int
        self.name = managedObject.value(forKey: "name") as? String
        self.language = managedObject.value(forKey: "language") as? String
        self.full_name = managedObject.value(forKey: "full_name") as? String
        self.description = managedObject.value(forKey: "desc") as? String
        self.forks_count = managedObject.value(forKey: "forks_count") as? Int
        self.stargazers_count = managedObject.value(forKey: "stargazers_count") as? Int
        self.isFavorite = isFavorite

    }
}

