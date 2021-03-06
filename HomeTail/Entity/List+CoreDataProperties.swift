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

    @nonobjc class func fetchRequest() -> NSFetchRequest<CockTailList> {
        return NSFetchRequest<CockTailList>(entityName: "CockTailList")
    }

    @NSManaged var name: String
    @NSManaged var subname: Int16
    @NSManaged var source: String
    @NSManaged var taste: String
    @NSManaged var base: String
    @NSManaged var alcohol: String
    @NSManaged var explain: String
    @NSManaged var recipe: [String]
    @NSManaged var cocktailimageurl: String
    @NSManaged var cockID: Int16
    @NSManaged var alcoholkind: String
}
