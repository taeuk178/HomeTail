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
    
    var objectData: [NSManagedObject]?
    var listData: [CockTailListModel]? = [CockTailListModel]()
    
    func fetchFiltering(onCompleted: @escaping ([CockTailListModel]) -> Void) {
        
        repository.fetchList { [weak self] object in
            
            self?.objectData = object
            self?.objectData = self?.objectData?.filter{ $0.value(forKey: "base") as? String != "진" }
//            self?.objectData = self?.objectData?.filter{ $0.value(forKey: "alcohol") as? Double == 5.5 }
//            self?.objectData = self?.objectData?.filter{
//                $0.value(forKey: "taste") as? String == SelectedItems.shared.taste! &&
//                $0.value(forKey: "base") as? String == SelectedItems.shared.base! &&
//                $0.value(forKey: "alcoholkind") as? String == SelectedItems.shared.alcohol!
//            }
            
            self?.objectData?.forEach({
                
                let cockTailList = CockTailListModel(cocktailImage: $0.value(forKey: "base") as? String ?? "",
                                       name: $0.value(forKey: "name") as? String ?? "",
                                       subName: $0.value(forKey: "subname") as? String ?? "",
                                       alcohol: $0.value(forKey: "alcohol") as? String ?? "")
                
                self?.listData?.append(cockTailList)
            })
            
            if let datas = self?.listData {
                onCompleted(datas)
            }
        }
    }
    
    var cockListData: [CockTailListFireStoreModel] = []
    var cockAllData: [[String: Any]]?
    // firestore
    func fetchFireStoreData(completion: @escaping ([CockTailListFireStoreModel]) -> Void) {
        
        repository.fetchAllList { model in
            
            model.forEach { data in
                guard let name = data["name"] as? String,
                      let subName = data["subName"] as? String,
                      let alcohol = data["alcohol"] as? Double else { return }
                
                let listData = CockTailListFireStoreModel(name: name, subName: subName, alcohol: alcohol)
                self.cockListData.append(listData)
            }
            self.cockAllData = model
            completion(self.cockListData)
        }
    }

}
