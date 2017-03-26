//
//  Calculator+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 26/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Calculator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculator> {
        return NSFetchRequest<Calculator>(entityName: "Calculator");
    }

    @NSManaged public var calculatorID: Int16
    @NSManaged public var input: String?
    @NSManaged public var name: String?
    @NSManaged public var output: String?
    @NSManaged public var toMany_Guideline: NSSet?

}

// MARK: Generated accessors for toMany_Guideline
extension Calculator {

    @objc(addToMany_GuidelineObject:)
    @NSManaged public func addToToMany_Guideline(_ value: Guideline)

    @objc(removeToMany_GuidelineObject:)
    @NSManaged public func removeFromToMany_Guideline(_ value: Guideline)

    @objc(addToMany_Guideline:)
    @NSManaged public func addToToMany_Guideline(_ values: NSSet)

    @objc(removeToMany_Guideline:)
    @NSManaged public func removeFromToMany_Guideline(_ values: NSSet)

}
