//
//  GLSource+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 27/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension GLSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GLSource> {
        return NSFetchRequest<GLSource>(entityName: "GLSource");
    }

    @NSManaged public var glSourceID: Int64
    @NSManaged public var glName: String?
    @NSManaged public var glsToMany_gl: Guideline?

}
