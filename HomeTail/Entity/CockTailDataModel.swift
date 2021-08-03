//
//  CockTailDataModel.swift
//  HomeTail
//
//  Created by taeuk on 2021/07/31.
//

import Foundation

struct FireCockTailModel: Codable {
    let cockID: Int
    let name: String
    let subName: String
    let taste: [String]
    let base: [String]
    let alcohol: Double
    let ingredient: String
    let description: String
}
