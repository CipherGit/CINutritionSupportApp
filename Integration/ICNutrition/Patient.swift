//
//  Patient.swift
//  ICNutrition
//
//  Created by Justin Peña on 24/2/17.
//  Integrated from Patient.swift by lijinjin.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation
public class Patient{
    var name: String
    var age: Int
    var gender: String
    var height: Int
    var weight: Int
    var admittedDate: String
    var icuWard: String
    //var nutricScore: Int
    
    init(name: String, age: Int, gender: String, height: Int, weight: Int, admittedDate: String, icuWard: String){
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.admittedDate = admittedDate
        self.icuWard = icuWard
        //self.nutricScore = nutriScore
    }
    
    func getName()->String{
        return self.name
    }
    
    func getAge()->Int{
        return self.age
    }
    
    func getGender()->String{
        return self.gender
    }
    
    func getHeight()->Int{
        return self.height
    }
    
    func getWeight()->Int{
        return self.weight
    }
    
    func getAdmittedDate()->String{
        return self.admittedDate
    }
    
    func getIcuWard()->String{
        return self.icuWard
    }

    
//    func getNutriScore()->Int{
//        return self.nutricScore
//    }
}
