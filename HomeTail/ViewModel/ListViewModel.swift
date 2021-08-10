//
//  ListViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/02.
//

import Foundation

class ListViewModel {
    
    let service = CockTailService()
    
    // coredata
    var cockList: [CockTailListModel]?
    
    func readCockTailList() {
        service.fetchFiltering { [weak self] model in
            self?.cockList = model
        }
    }
    
    // firestore
    
    var cockTailList: [CockTailListFireStoreModel]?
    
    func readCockTailFireStoreData(completion: @escaping () -> Void) {
        service.fetchFireStoreData { [weak self] model in
            self?.cockTailList = model
            completion()
        }
    }
}
