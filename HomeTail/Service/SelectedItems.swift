//
//  SelectedItems.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/02.
//

import Foundation

class SelectedItems {
    
    static let shared = SelectedItems()
    
    private init() {}
    
    var taste: String?
    var base: String?
    var alcohol: String?
}
