//
//  ICUWard+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension ICUWard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ICUWard> {
        return NSFetchRequest<ICUWard>(entityName: "ICUWard");
    }

    @NSManaged public var admitDate: NSDate?
    @NSManaged public var icuWardID: Int16
    @NSManaged public var wardName: String?

}
