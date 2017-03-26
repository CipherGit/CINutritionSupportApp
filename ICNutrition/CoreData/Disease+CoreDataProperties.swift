//
//  Disease+CoreDataProperties.swift
//  ICNutrition
//
//  Created by Justin Peña on 26/3/17.
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
    @NSManaged public var notes: String?
    @NSManaged public var toMany_Rec: NSSet?

}

// MARK: Generated accessors for toMany_Rec
extension Disease {

    @objc(addToMany_RecObject:)
    @NSManaged public func addToToMany_Rec(_ value: Recommendation)

    @objc(removeToMany_RecObject:)
    @NSManaged public func removeFromToMany_Rec(_ value: Recommendation)

    @objc(addToMany_Rec:)
    @NSManaged public func addToToMany_Rec(_ values: NSSet)

    @objc(removeToMany_Rec:)
    @NSManaged public func removeFromToMany_Rec(_ values: NSSet)

}
