//
//  ListViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/02.
//

import Foundation

class ListViewModel {
    
    let service = CockTailService()
    
    func readCockTailList() {
        service.fetchFiltering { [weak self] model in
            print(model)
        }
    }
}
