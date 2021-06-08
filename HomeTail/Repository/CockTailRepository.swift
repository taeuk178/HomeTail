//
//  CockTailRepository.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation
import CoreData

class CockTailRepository {
    
    let context = PersistenceManager.shared.context
    
    func fetchList(onCompleted: @escaping ([NSManagedObject]) -> Void ) {
        // fetch
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "CockTailList")
        do {
            let contact = try context.fetch(fetch)
            onCompleted(contact)
        } catch {
            print("err")
        }
    }
}
