//
//  HomeViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation

class HomeViewModel {
    
    let service = CockTailService()
    
    let name: Dynamic<String> = Dynamic("맛을 선택해 주세용")
    let connectCase: Dynamic<SelectedCases> = Dynamic(.taste)
    
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
}
