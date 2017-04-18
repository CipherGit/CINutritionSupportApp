//
//  Patient+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 17/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var admitDate: NSDate?
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?
    @NSManaged public var height: Int16
    @NSManaged public var name: String?
    @NSManaged public var patientID: Int64
    @NSManaged public var weight: Int16
    @NSManaged public var nType: String?
    @NSManaged public var patientToMany_Disease: NSSet?
    @NSManaged public var patientToMany_Rec: NSSet?
    @NSManaged public var patientToOne_Ward: ICUWard?

}

// MARK: Generated accessors for patientToMany_Disease
extension Patient {

    @objc(addPatientToMany_DiseaseObject:)
    @NSManaged public func addToPatientToMany_Disease(_ value: Disease)

    @objc(removePatientToMany_DiseaseObject:)
    @NSManaged public func removeFromPatientToMany_Disease(_ value: Disease)

    @objc(addPatientToMany_Disease:)
    @NSManaged public func addToPatientToMany_Disease(_ values: NSSet)

    @objc(removePatientToMany_Disease:)
    @NSManaged public func removeFromPatientToMany_Disease(_ values: NSSet)

}

// MARK: Generated accessors for patientToMany_Rec
extension Patient {

    @objc(addPatientToMany_RecObject:)
    @NSManaged public func addToPatientToMany_Rec(_ value: Recommendation)

    @objc(removePatientToMany_RecObject:)
    @NSManaged public func removeFromPatientToMany_Rec(_ value: Recommendation)

    @objc(addPatientToMany_Rec:)
    @NSManaged public func addToPatientToMany_Rec(_ values: NSSet)

    @objc(removePatientToMany_Rec:)
    @NSManaged public func removeFromPatientToMany_Rec(_ values: NSSet)

}
