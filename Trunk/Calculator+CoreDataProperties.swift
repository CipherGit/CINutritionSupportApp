//
//  Calculator+CoreDataProperties.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData


extension Calculator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculator> {
        return NSFetchRequest<Calculator>(entityName: "Calculator");
    }

    @NSManaged public var calculatorID: Int16
    @NSManaged public var name: String?
    @NSManaged public var input: String?
    @NSManaged public var output: String?

}
