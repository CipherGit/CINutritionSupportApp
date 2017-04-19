//
//  GLSource+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 20/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension GLSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GLSource> {
        return NSFetchRequest<GLSource>(entityName: "GLSource")
    }

    @NSManaged public var glName: String?
    @NSManaged public var glSourceID: Int64
    @NSManaged public var glsToMany_gl: NSSet?

}

// MARK: Generated accessors for glsToMany_gl
extension GLSource {

    @objc(addGlsToMany_glObject:)
    @NSManaged public func addToGlsToMany_gl(_ value: Guideline)

    @objc(removeGlsToMany_glObject:)
    @NSManaged public func removeFromGlsToMany_gl(_ value: Guideline)

    @objc(addGlsToMany_gl:)
    @NSManaged public func addToGlsToMany_gl(_ values: NSSet)

    @objc(removeGlsToMany_gl:)
    @NSManaged public func removeFromGlsToMany_gl(_ values: NSSet)

}
