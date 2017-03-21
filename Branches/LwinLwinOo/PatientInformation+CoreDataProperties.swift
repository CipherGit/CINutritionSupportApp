//
//  PatientInformation+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 16/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension PatientInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientInformation> {
        return NSFetchRequest<PatientInformation>(entityName: "PatientInformation");
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?
    @NSManaged public var weight: Int16
    @NSManaged public var height: Int16
    @NSManaged public var date: String?
    @NSManaged public var icuward: String?

}
