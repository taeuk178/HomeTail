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
    
    // 3
//    var ttss: Dynamic<String?> = Dynamic(nil)
    let name: Dynamic<String> = Dynamic("init")
    
    //
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
}

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ varible: T) {
        value = varible
    }
}

