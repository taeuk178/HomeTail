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
    
    /* ** 기능 구현
     
     다음, 이전 기능
     */
    
    func nextCase(index: Int) {
        
        switch connectCase.value {
        case .taste:
            connectCase.value = .base
            print(SelectedCases.taste.rawValues[index])
        case .base:
            connectCase.value = .alcohol
            print(SelectedCases.base.rawValues[index])
        case .alcohol:
            print("end")
            print(SelectedCases.alcohol.rawValues[index])
        }
    }
    
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
}
