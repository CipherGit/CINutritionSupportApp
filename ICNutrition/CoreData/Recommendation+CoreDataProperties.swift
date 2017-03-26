//
//  Recommendation+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 26/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Recommendation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recommendation> {
        return NSFetchRequest<Recommendation>(entityName: "Recommendation");
    }

    @NSManaged public var recID: Int16
    @NSManaged public var diseases_diseasesID: Disease?
    @NSManaged public var guidelines_guidelinesID: Guideline?
    @NSManaged public var patient_patientID: Patient?

}
