//
//  Index+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Index {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Index> {
        return NSFetchRequest<Index>(entityName: "Index");
    }

    @NSManaged public var indexID: Int64
    @NSManaged public var keywords: String?
    @NSManaged public var idxToOne_GL: Guideline?

}
