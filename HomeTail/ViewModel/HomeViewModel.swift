//
//  HomeViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation

class HomeViewModel {
    
    let service = CockTailService()
    
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
}
