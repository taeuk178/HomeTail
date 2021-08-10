//
//  CockTailModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/08.
//

import Foundation

struct CockTailDataTestModel {
    var base: String
}

struct CockTailListModel {
    let cocktailImage: String
    let name: String
    let subName: String
    let alcohol: String
}

// FiresStore

struct CockTailListFireStoreModel {
    let name: String
    let subName: String
    let alcohol: Double    
}

struct CockTailRecipeModel {
    let name: String
    let subName: String
    let alcohol: Double
    let ingredient: String
    let description: String
}
