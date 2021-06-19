//
//  SelectedItemList.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/19.
//

import Foundation

/// 선택 경우의 수
enum SeletedCases {
    case taste
    case base
    case alcohol
}

/// 맛 선택
enum SelectedTaste {
    case sweet
    case sour
    case dry
    case all
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
enum SelectedBase {
    case nonAlcohol
    case gin
    case vodka
    case rum
    case tequila
    case liqueur
    case whisky
    case brandy
    case others
    case all
}

/*
 case nonAlcohol = 0
 case five = 1 ~ 5
 case ten = 6 ~ 10
 case fifteen = 11 ~ 15
 case twenty = 16 ~ 20
 case twentyfive = 21 ~ 25
 case thirty = 26 ~ 30
 case thirtyfive = 31 ~ 35
 case fortyplus = 35 ~ 40
 case alpha = 40
 */

/// 도수 선택
enum SelectedAlcohol {
    case nonAlcohol
    case five
    case ten
    case fifteen
    case twenty
    case twentyfive
    case thirty
    case thirtyfive
    case forty
    case alpha
    case all
}
