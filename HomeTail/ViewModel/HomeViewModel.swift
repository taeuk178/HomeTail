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
    
    // 화면 전환
    weak var delegateCoordinator: SubCoordinator?
    
    /* ** 기능 구현
     
     다음, 이전 기능
     */
    
    func nextCase(index: Int) {
        
        switch connectCase.value {
        case .taste:
            selectedShared.taste = SelectedCases.taste.rawValues[index]
            connectCase.value = .base
            print(SelectedCases.taste.rawValues[index])
        case .base:
            selectedShared.base = SelectedCases.base.rawValues[index]
            if SelectedCases.base.rawValues[index] == "무알콜" {
                selectedShared.alcohol = "무알콜"
                delegateCoordinator?.presenter()
                print(selectedShared.taste, selectedShared.base, selectedShared.alcohol)
                break
            }
            connectCase.value = .alcohol
            print(SelectedCases.base.rawValues[index])
        case .alcohol:
            selectedShared.alcohol = SelectedCases.alcohol.rawValues[index]
            print(selectedShared.taste, selectedShared.base, selectedShared.alcohol)
            delegateCoordinator?.presenter()
        }
    }
    
    // service 삭제예정
    
    let service = CockTailService()
    
    func readService() {
        service.fetchRepository { [weak self] model in
            print(model)
        }
    }
}
