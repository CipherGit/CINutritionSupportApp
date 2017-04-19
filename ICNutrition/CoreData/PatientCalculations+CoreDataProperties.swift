//
//  PatientCalculations+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 20/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension PatientCalculations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientCalculations> {
        return NSFetchRequest<PatientCalculations>(entityName: "PatientCalculations")
    }

    @NSManaged public var input: String?
    @NSManaged public var output: String?
    @NSManaged public var plcToOne_Patient: Patient?
    @NSManaged public var plcToOne_Calculator: Calculator?

}
