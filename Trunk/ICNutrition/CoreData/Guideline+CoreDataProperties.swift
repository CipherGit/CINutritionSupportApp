//
//  Guideline+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 26/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Guideline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guideline> {
        return NSFetchRequest<Guideline>(entityName: "Guideline");
    }

    @NSManaged public var category: String?
    @NSManaged public var fullDescription: String?
    @NSManaged public var guideLineID: Int16
    @NSManaged public var shorthand: String?
    @NSManaged public var source: String?
    @NSManaged public var calculator_calculatorID: Calculator?
    @NSManaged public var toOne_index: Index?
    @NSManaged public var toMany_Rec: NSSet?

}

// MARK: Generated accessors for toMany_Rec
extension Guideline {

    @objc(addToMany_RecObject:)
    @NSManaged public func addToToMany_Rec(_ value: Recommendation)

    @objc(removeToMany_RecObject:)
    @NSManaged public func removeFromToMany_Rec(_ value: Recommendation)

    @objc(addToMany_Rec:)
    @NSManaged public func addToToMany_Rec(_ values: NSSet)

    @objc(removeToMany_Rec:)
    @NSManaged public func removeFromToMany_Rec(_ values: NSSet)

}
