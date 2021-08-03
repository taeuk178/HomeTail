//
//  SelectedItemList.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/19.
//

import Foundation

/// 선택 경우의 수
enum SelectedCases {
    case taste
    case base
    case alcohol
    
    var texture: String {
        switch self {
        case .taste:
            return "맛"
        case .base:
            return "기주"
        case .alcohol:
            return "도수"
        }
    }
    
    var allCount: Int {
        switch self {
        case .taste:
            return SelectedTaste.allCases.count
        case .base:
            return SelectedBase.allCases.count
        case .alcohol:
            return SelectedAlcohol.allCases.count
        }
    }
    
    var rawValues: [String] {
        switch self {
        case .taste:
            return SelectedTaste.allValues
        case .base:
            return SelectedBase.allValues
        case .alcohol:
            return SelectedAlcohol.allValues
        }
    }
}

extension CaseIterable where Self: RawRepresentable {
    static var allValues: [RawValue] {
        return allCases.map { $0.rawValue }
    }
}

/// 맛 선택
enum SelectedTaste: String, CaseIterable {
    case sweet = "달콤"
    case sour = "새콤"
    case dry = "담백"
    case all = "모두"
    // Sweet = 빨강느낌의 주황
    // Sour = 레몬색
    // Dry = 커피색 갈색
    // 모두 = 잔 색
}

/*
# 0619 Data 수정예정
 논알콜 = 1000
 진 = 2000
 보드카 = 3000
 럼 = 4000
 데낄라 = 5000
 리큐르 = 6000
 위스키 = 7000
 브랜디 = 8000
 기타 = 9000 ( 맥주, 와인 등 )
 몰라요 = 10000
 
 source = "출처" -> 변수명 변경 필요
 */

/// 기주 선택
enum SelectedBase: String, CaseIterable {
    case nonAlcohol = "무알콜"
    case gin = "진"
    case vodka = "보드카"
    case rum = "럼"
    case tequila = "데킬라"
    case liqueur = "리큐르"
    case whisky = "위스키"
    case brandy = "브랜디"
    case others = "기타"
    case all = "모두 선택"
    
    // 무알콜 = 흰색
    // 나머지 투명
    // 모두 = 잔색
}

/*
 case nonAlcohol = 0
 case low
 case medium
 case high
 case all
 */

/// 도수 선택
enum SelectedAlcohol: String, CaseIterable {
    case low = "낮은 도수"
    case medium = "중간 도수"
    case high = "높은 도수"
    case all = "모두 선택"
    
    // 낮은 = 연한색
    // 중간 = 조금 짙은
    // 높은 = 짙은
    // 모두 = 잔
}
