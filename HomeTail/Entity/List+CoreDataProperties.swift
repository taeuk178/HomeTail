//
//  List+CoreDataProperties.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/07.
//
//

import Foundation
import CoreData

extension CockTailList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CockTailList> {
        return NSFetchRequest<CockTailList>(entityName: "CockTailList")
    }

    @NSManaged public var name: String
    @NSManaged public var source: String
    @NSManaged public var base: String
    @NSManaged public var taste: String
    @NSManaged public var technique: String
    @NSManaged public var glass: String
    @NSManaged public var explain: String
    @NSManaged public var amount: [Int]
    @NSManaged public var recipe: [String]
    @NSManaged public var cocktailimageurl: String
    @NSManaged public var id: Int16

}

extension CockTailList: Identifiable {

}
