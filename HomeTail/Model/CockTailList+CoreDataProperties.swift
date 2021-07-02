//
//  CockTailList+CoreDataProperties.swift
//  
//
//  Created by taeuk on 2021/07/02.
//
//

import Foundation
import CoreData


extension CockTailList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CockTailList> {
        return NSFetchRequest<CockTailList>(entityName: "CockTailList")
    }

    @NSManaged public var base: String?
    @NSManaged public var cockID: Int16
    @NSManaged public var cocktailimageurl: String?
    @NSManaged public var explain: String?
    @NSManaged public var name: String?
    @NSManaged public var recipe: [String]?
    @NSManaged public var source: String?
    @NSManaged public var subname: String?
    @NSManaged public var taste: String?
    @NSManaged public var alcohol: Double

}
