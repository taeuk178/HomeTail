//
//  CockTailService.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation
import CoreData

class CockTailService {
    let repository = CockTailRepository()
    
    var currentModel = CockTailDataTestModel(base: "")
    
    func fetchRepository(onCompleted: @escaping (CockTailDataTestModel) -> Void ) {
        
        repository.fetchList { [weak self] object in
        
            let model = CockTailDataTestModel(base: object[0].value(forKey: "base") as? String ?? "")
            self?.currentModel = model
            onCompleted(model)
            
        }
    }
    
    func fetchFiltering(onCompleted: @escaping (CockTailDataTestModel) -> Void) {
        
        repository.fetchList { [weak self] object in
            let tts = object.filter{ $0.value(forKey: "base") as? String != "진" }
            let model = CockTailDataTestModel(base: tts[0].value(forKey: "base") as? String ?? "")
            onCompleted(model)
        }
    }
}

// Coredata 싱글턴

class PersistenceManager {
    static let shared = PersistenceManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CockTailList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context = persistentContainer.viewContext
}
