//
//  PatientCalculation+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 20/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension PatientCalculation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientCalculation> {
        return NSFetchRequest<PatientCalculation>(entityName: "PatientCalculation")
    }

    @NSManaged public var input: String?
    @NSManaged public var output: String?
    @NSManaged public var ptcToPatient: Patient?
    @NSManaged public var ptcToCalc: Calculator?

}
