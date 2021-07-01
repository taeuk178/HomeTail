//
//  PersistanceManager.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/02.
//

import UIKit
import CoreData

// Coredata 싱글턴

class PersistenceManager {
    static let shared = PersistenceManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CockTailList")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context = persistentContainer.viewContext
}
