//
//  coreDataManagedObject.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 16/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension NSObject{
    
    var context: NSManagedObjectContext?{
        return (UIApplication.shared.delegate as? AppDelegate)?
            .persistentContainer.viewContext
    }
    
}

