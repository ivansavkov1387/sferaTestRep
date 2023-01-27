//
//  CoreDataStack.swift
//  sferaTest
//
//  Created by Иван on 25.12.22.
//

import CoreData
import Foundation

final class CDStack {
    private var persistentContainer: NSPersistentContainer!
    var mainViewContext: NSManagedObjectContext!
    var backgroundViewContext: NSManagedObjectContext!
    
    init() {
        let container = NSPersistentContainer(name: "sferaItem")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
        mainViewContext = persistentContainer?.viewContext
        backgroundViewContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundViewContext.parent = mainViewContext
    }
    
    func saveContext() {
        if backgroundViewContext.hasChanges {
            do {
                try backgroundViewContext.save()
            } catch let error as NSError {
                print("ERROR - \(error), \(error.userInfo)")
            }
        }
        if mainViewContext.hasChanges {
            do {
                try mainViewContext.save()
            } catch let error as NSError {
                print("ERROR - \(error), \(error.userInfo)")
            }
        }
    }
}



