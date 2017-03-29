//
//  Recommendation+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Recommendation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recommendation> {
        return NSFetchRequest<Recommendation>(entityName: "Recommendation");
    }

    @NSManaged public var recID: Int64
    @NSManaged public var recToOne_Patient: Patient?
    @NSManaged public var recToOne_Guideline: Guideline?

}
