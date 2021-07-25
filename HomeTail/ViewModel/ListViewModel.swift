//
//  ListViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/02.
//

import Foundation

class ListViewModel {
    
    let service = CockTailService()
    
    var cockList: [CockTailListModel]?
    
    func readCockTailList() {
        service.fetchFiltering { [weak self] model in
            self?.cockList = model
        }
    }
}
