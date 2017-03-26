//
//  Disease+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Disease {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Disease> {
        return NSFetchRequest<Disease>(entityName: "Disease");
    }

    @NSManaged public var diseaseID: Int16
    @NSManaged public var diseaseName: String?
    @NSManaged public var diseaseSeverity: String?
    @NSManaged public var diseaseNotes: String?
    @NSManaged public var disToOne_Patient: Patient?

}
