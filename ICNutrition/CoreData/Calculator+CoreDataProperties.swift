//
//  Calculator+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 20/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Calculator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculator> {
        return NSFetchRequest<Calculator>(entityName: "Calculator")
    }

    @NSManaged public var calcID: Int64
    @NSManaged public var calcName: String?
    @NSManaged public var calcToMany_gl: NSSet?
    @NSManaged public var calcToMany_ptc: NSSet?

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

// MARK: Generated accessors for calcToMany_ptc
extension Calculator {

    @objc(addCalcToMany_ptcObject:)
    @NSManaged public func addToCalcToMany_ptc(_ value: PatientCalculation)

    @objc(removeCalcToMany_ptcObject:)
    @NSManaged public func removeFromCalcToMany_ptc(_ value: PatientCalculation)

    @objc(addCalcToMany_ptc:)
    @NSManaged public func addToCalcToMany_ptc(_ values: NSSet)

    @objc(removeCalcToMany_ptc:)
    @NSManaged public func removeFromCalcToMany_ptc(_ values: NSSet)

}
