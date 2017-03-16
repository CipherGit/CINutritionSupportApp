//
//  Patient.swift
//  CI1
//
//  Created by lijinjin on 22/2/17.
//  Copyright © 2017 lijinjin. All rights reserved.
//

import Foundation
public class Patient{
    var name: String //var price : Double = 0.0
    var age: Int
    var gender: String
    var height: Int
    var weight: Int
    var admittedDate: String
    var nutricScore: Int
    
    init(name: String, age: Int, gender: String, height: Int, weight: Int, admittedDate: String, nutriScore: Int){
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.admittedDate = admittedDate
        self.nutricScore = nutriScore
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
    
    func getNutriScore()->Int{
        return self.nutricScore
    }
}
