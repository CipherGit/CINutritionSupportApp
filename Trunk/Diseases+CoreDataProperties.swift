//
//  Diseases+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Diseases {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diseases> {
        return NSFetchRequest<Diseases>(entityName: "Diseases");
    }

    @NSManaged public var diseaseID: Int16
    @NSManaged public var diseaseName: String?
    @NSManaged public var notes: String?

}
