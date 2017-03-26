//
//  ICUWard+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension ICUWard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ICUWard> {
        return NSFetchRequest<ICUWard>(entityName: "ICUWard");
    }

    @NSManaged public var icuWardID: Int64
    @NSManaged public var wardName: String?
    @NSManaged public var wardToOne_Patient: Patient?

}
