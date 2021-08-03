//
//  CockTailRepository.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation
import CoreData
import Firebase

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
        
    func fetchAllList(completion: @escaping ([[String: Any]]) -> Void) {
        
        var allData: [[String: Any]] = [[:]]
        
        let ref = Firestore.firestore().collection("CockData")
        ref.getDocuments { snapshot, error in
            if let err = error {
                print("Repository Error: ", err.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    print(document.documentID)
                    allData.append(document.data())
                }
                completion(allData)
            }
        }
    }
}
