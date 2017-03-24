//
//  Recommendations+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Recommendations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recommendations> {
        return NSFetchRequest<Recommendations>(entityName: "Recommendations");
    }

    @NSManaged public var recID: Int16
    @NSManaged public var patient_patientID: PatientInformation?
    @NSManaged public var guidelines_guidelinesID: Guidelines?
    @NSManaged public var diseases_diseasesID: Diseases?

}
