//
//  ICUWard+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 26/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension ICUWard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ICUWard> {
        return NSFetchRequest<ICUWard>(entityName: "ICUWard");
    }

    @NSManaged public var icuWardID: Int16
    @NSManaged public var wardName: String?
    @NSManaged public var toMany_patient: NSSet?

}

// MARK: Generated accessors for toMany_patient
extension ICUWard {

    @objc(addToMany_patientObject:)
    @NSManaged public func addToToMany_patient(_ value: Patient)

    @objc(removeToMany_patientObject:)
    @NSManaged public func removeFromToMany_patient(_ value: Patient)

    @objc(addToMany_patient:)
    @NSManaged public func addToToMany_patient(_ values: NSSet)

    @objc(removeToMany_patient:)
    @NSManaged public func removeFromToMany_patient(_ values: NSSet)

}
