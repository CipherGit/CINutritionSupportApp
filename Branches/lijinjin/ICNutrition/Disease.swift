//
//  Disease.swift
//  ICNutrition
//
//  Created by lijinjin on 14/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
public class Disease{
    var diseaseName: String
    var severityLevel: String
    var notes: String
    
    init(diseaseName: String, severityLevel: String, notes: String){
        self.diseaseName = diseaseName
        self.severityLevel = severityLevel
        self.notes = notes
    }
    
    func getDiseaseName()->String{
        return self.diseaseName
    }
    
    func getSeverityLevel()->String{
        return self.severityLevel
    }
    
    func getNotes()->String{
        return self.notes
    }
    

}
