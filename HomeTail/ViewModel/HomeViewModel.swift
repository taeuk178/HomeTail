//
//  HomeViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation

class HomeViewModel {
    
    var listener: ((String) -> Void)?
    
    let service = CockTailService()
    
    func bind(action: @escaping (String) -> Void ) {
        self.listener = action
    }
    
    func bindData(_ data: String) {
        listener?(data)
    }
    
    // 2
    var onUpdated: () -> Void = {}
    
    var dateTest: String = "test.." {
        didSet {
            onUpdated()
        }
    }
    //
    
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
}
