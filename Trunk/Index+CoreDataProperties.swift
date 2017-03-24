//
//  Index+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Index {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Index> {
        return NSFetchRequest<Index>(entityName: "Index");
    }

    @NSManaged public var indexID: Int16
    @NSManaged public var keywords: String?
    @NSManaged public var guidelines_guidelinesID: Guidelines?

}
