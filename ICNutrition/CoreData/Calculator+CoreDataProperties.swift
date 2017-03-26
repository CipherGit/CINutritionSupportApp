//
//  Calculator+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Calculator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculator> {
        return NSFetchRequest<Calculator>(entityName: "Calculator");
    }

    @NSManaged public var calcID: Int64
    @NSManaged public var input: String?
    @NSManaged public var output: String?
    @NSManaged public var calcName: String?
    @NSManaged public var calcToMany_gl: NSSet?

}

// MARK: Generated accessors for calcToMany_gl
extension Calculator {

    @objc(addCalcToMany_glObject:)
    @NSManaged public func addToCalcToMany_gl(_ value: Guideline)

    @objc(removeCalcToMany_glObject:)
    @NSManaged public func removeFromCalcToMany_gl(_ value: Guideline)

    @objc(addCalcToMany_gl:)
    @NSManaged public func addToCalcToMany_gl(_ values: NSSet)

    @objc(removeCalcToMany_gl:)
    @NSManaged public func removeFromCalcToMany_gl(_ values: NSSet)

}
