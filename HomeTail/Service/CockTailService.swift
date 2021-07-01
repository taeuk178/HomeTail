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
    
    var listData: [NSManagedObject]?
    
    func fetchFiltering(onCompleted: @escaping (CockTailDataTestModel) -> Void) {
        
        repository.fetchList { [weak self] object in
            self?.listData = object
            self?.listData = self?.listData?.filter{ $0.value(forKey: "base") as? String != "진" }
            let model = CockTailDataTestModel(base: self?.listData?[0].value(forKey: "base") as? String ?? "")
            onCompleted(model)
        }
    }
}
