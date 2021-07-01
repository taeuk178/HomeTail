//
//  HomeViewModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation

class HomeViewModel {
    
    let selectedShared = SelectedItems.shared
    
    let name: Dynamic<String> = Dynamic("맛을 선택해 주세용")
    let connectCase: Dynamic<SelectedCases> = Dynamic(.taste)
    
    /* ** 기능 구현
     
     다음, 이전 기능
     */
    
    func nextCase(index: Int) {
        
        switch connectCase.value {
        case .taste:
            connectCase.value = .base
            selectedShared.taste = SelectedCases.taste.rawValues[index]
            print(SelectedCases.taste.rawValues[index])
        case .base:
            connectCase.value = .alcohol
            selectedShared.base = SelectedCases.base.rawValues[index]
            print(SelectedCases.base.rawValues[index])
        case .alcohol:
            selectedShared.alcohol = SelectedCases.alcohol.rawValues[index]
            print(selectedShared.taste, selectedShared.base, selectedShared.alcohol)
            testService()
        }
    }
    
    // service 삭제예정
    
    let service = CockTailService()
    
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
    
    func testService() {
        service.fetchFiltering { [weak self] model in
            print(model)
        }
    }
}
