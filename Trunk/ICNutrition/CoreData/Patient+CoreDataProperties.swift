//
//  Patient+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 26/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient");
    }

    @NSManaged public var age: Int16
    @NSManaged public var date: String?
    @NSManaged public var gender: String?
    @NSManaged public var height: Int16
    @NSManaged public var icuward: String?
    @NSManaged public var name: String?
    @NSManaged public var weight: Int16
    @NSManaged public var admitDate: NSDate?
    @NSManaged public var icuWard_icuWardID: ICUWard?
    @NSManaged public var toMany_rec: NSSet?

}

// MARK: Generated accessors for toMany_rec
extension Patient {

    @objc(addToMany_recObject:)
    @NSManaged public func addToToMany_rec(_ value: Recommendation)

    @objc(removeToMany_recObject:)
    @NSManaged public func removeFromToMany_rec(_ value: Recommendation)

    @objc(addToMany_rec:)
    @NSManaged public func addToToMany_rec(_ values: NSSet)

    @objc(removeToMany_rec:)
    @NSManaged public func removeFromToMany_rec(_ values: NSSet)

}
