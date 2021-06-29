//
//  Extension+UIFont.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/17.
//

import UIKit

// 한국어용 폰트
enum KoreanFont: String {
    case sansHWBold = "SourceHanSansHWK-Bold"
    case sansHWRegular = "SourceHanSansHWK-Regular"
}

// 영문체용 폰트
enum EnglishFont: String {
    case helveticaBold = "HelveticaNeue-Bold"
    case helveticaMedium = "HelveticaNeue-Medium"
    case helveticaLight = "HelveticaNeue-Light"
    case heveticaThin = "HelveticaNeue-Thin"
}

extension UIFont {
    
    static func appSansFont(_ kind: KoreanFont, size: CGFloat) -> UIFont {
        switch kind {
        
        case .sansHWBold:
            guard let font = UIFont(name: kind.rawValue, size: size) else { return UIFont() }
            return font
            
        case .sansHWRegular:
            guard let font = UIFont(name: kind.rawValue, size: size) else { return UIFont() }
            return font
                
        }
    }
    
    static func apphelveticaFont(_ kind: EnglishFont, size: CGFloat) -> UIFont {
        
        switch kind {
        
        case .helveticaBold:
            guard let font = UIFont(name: kind.rawValue, size: size) else { return UIFont() }
            return font
            
        case .helveticaMedium:
            guard let font = UIFont(name: kind.rawValue, size: size) else { return UIFont() }
            return font
            
        case .helveticaLight:
            guard let font = UIFont(name: kind.rawValue, size: size) else { return UIFont() }
            return font
            
        case .heveticaThin:
            guard let font = UIFont(name: kind.rawValue, size: size) else { return UIFont() }
            return font
        }
    }
}
