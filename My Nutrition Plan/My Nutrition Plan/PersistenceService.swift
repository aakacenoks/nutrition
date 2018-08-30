//
//  PersistenceService.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 13/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService{
	
    private init(){}

    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
	
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData") 
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
		
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
