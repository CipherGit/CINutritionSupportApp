//
//  Guideline+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Guideline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guideline> {
        return NSFetchRequest<Guideline>(entityName: "Guideline");
    }

    @NSManaged public var gID: Int64
    @NSManaged public var shortDesc: String?
    @NSManaged public var fullDesc: String?
    @NSManaged public var category: String?
    @NSManaged public var identifier: String?
    @NSManaged public var glToOne_GLSource: GLSource?
    @NSManaged public var glToOne_Index: Index?
    @NSManaged public var glToOne_Calc: Calculator?
    @NSManaged public var glToMany_Rec: NSSet?

}

// MARK: Generated accessors for glToMany_Rec
extension Guideline {

    @objc(addGlToMany_RecObject:)
    @NSManaged public func addToGlToMany_Rec(_ value: Recommendation)

    @objc(removeGlToMany_RecObject:)
    @NSManaged public func removeFromGlToMany_Rec(_ value: Recommendation)

    @objc(addGlToMany_Rec:)
    @NSManaged public func addToGlToMany_Rec(_ values: NSSet)

    @objc(removeGlToMany_Rec:)
    @NSManaged public func removeFromGlToMany_Rec(_ values: NSSet)

}
