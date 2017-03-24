//
//  Guidelines+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Guidelines {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guidelines> {
        return NSFetchRequest<Guidelines>(entityName: "Guidelines");
    }

    @NSManaged public var guideLineID: Int16
    @NSManaged public var shorthand: String?
    @NSManaged public var category: String?
    @NSManaged public var source: String?
    @NSManaged public var fullDescription: String?
    @NSManaged public var calculator_calculatorID: Calculator?

}
