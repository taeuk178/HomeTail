//
//  Extension+UIcolor.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/09.
//

import UIKit

enum MainColor {
    
    case subOrangeColor
    case subYelloColor
    case subWhiteColor
    case subSkyBlueColor
    
}

extension UIColor {
    
    static func appMainColor(_ kind: MainColor) -> UIColor {
        switch kind {
        case .subOrangeColor:
            return UIColor(red: 255/255, green: 164/255, blue: 91/255, alpha: 1.0)
        case .subYelloColor:
            return UIColor(red: 255/255, green: 218/255, blue: 119/255, alpha: 1.0)
        case .subWhiteColor:
            return UIColor(red: 251/255, green: 246/255, blue: 240/255, alpha: 1.0)
        case .subSkyBlueColor:
            return UIColor(red: 174/255, green: 230/255, blue: 230/255, alpha: 1.0)
        }
    }
    
    func customRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat?) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha ?? 1.0)
    }

}
