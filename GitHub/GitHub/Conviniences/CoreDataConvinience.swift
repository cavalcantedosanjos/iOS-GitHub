//
//  CoreDataConvinience.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import CoreData


class CoreDataConvinience {
    
    let repositoryEntityName = "Repo"
    
    func context() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         return appDelegate.persistentContainer.viewContext
    }

    func save(repository: Repository) {

        let entity = NSEntityDescription.entity(forEntityName: repositoryEntityName, in: context())
        _ = repository.toManagedObject(entity: entity!, insertInto: context())
        do {
            try context().save()
        } catch {
            print("Failed saving")
        }
     
    }

    func load() -> [Repository] {

        var repos: [Repository] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context().fetch(request)
            for data in result as! [NSManagedObject] {
                repos.append(Repository(from: data, isFavorite: true))
            }
        } catch {
            print("Failed")
 
        }
        
        return repos
    }
    
    func load(by user: User) -> [Repository] {
        
        var repos: [Repository] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntityName)
         request.predicate = NSPredicate(format: "owner == %@", user.login ?? "")
        do {
            let result = try context().fetch(request)
            for data in result as! [NSManagedObject] {
                repos.append(Repository(from: data, isFavorite: true))
            }
        } catch {
            print("Failed")
            
        }
        
        return repos
    }
    
    
    func delete(repository: Repository) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: repositoryEntityName)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "id == %d", repository.id!)

        do {
            let result = try context().fetch(request)
            for data in result as! [NSManagedObject] {
                context().delete(data)
            }
            try context().save()
        } catch {
            print("Failed")
        }
    }
}
