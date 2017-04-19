//
//  CaloricRequirements.swift
//  ICNutrition
//
//  Created by Justin Peña on 18/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation

class CaloricRequirementCalculator : CalculatorProtocol {
    
    //Protocol Variables
    var formulas : [String] = []
    var input: [String : (value: String, type: String, option: String)] = [:]
    var output: [String : (value: String, units: String)] = [:]
    
    //Calculator Specific
    var injuryFactors = [String:Float]()
    var activityFactors = [String:Float]()
    
    let tempActivityFactor = 1.2
    let carbohydrate = 4
    let protein = 4
    let fat = 9
    
    init(){
        formulas = ["Harris-Benedict (1919)", "Roza-Shizgal (1984)", "Mifflin-St Jeor (1990)"]
        
        //Source: https://www.med-ed.virginia.edu/pda/refcards/criticalcare/Cal.htm
        injuryFactors = ["Normal" : 1.0,
                         "Infection - Mild" : 1.1,
                         "Infection - Moderate" : 1.25,
                         "Infection - Severe" : 1.45,
                         "Infection - Peritonitis" : 1.15,
                         "Operation - Minor" : 1.1,
                         "Operation - Major" : 1.15,
                         "Post-op" : 1.05,
                         "Burns < 20%" : 1.5,
                         "Burns 20%-40%" : 1.7,
                         "Burns > 40%" : 2.0,
                         "Trauma - Multiple" : 1.3,
                         "Trauma - Blunt" : 1.4,
                         "Trauma - Skeletal" : 1.2,
                         "Trauma - Long-bone fracture" : 1.25,
                         "Cancer" : 1.15]
        activityFactors = ["Bedridden" : 1.2,
                           "Ambulating" : 1.25]
        
        let injKeyArr = Array(injuryFactors.keys)
        var injuryKeyString = ""
        var first = false
        for key in injKeyArr {
            if(!first) {
                injuryKeyString += key
                first = true
                continue
            }
            injuryKeyString += "," + key
        }
        
        let actKeyArr = Array(activityFactors.keys)
        var actKeyString = ""
        first = false
        for key in actKeyArr {
            if(!first){
                actKeyString += key
                first = true
                continue
            }
            actKeyString +=  "," + key
        }
        
        input = ["Age" : (value:"0", type:"numeric", option:""),
                 "Height" : (value:"0", type:"numeric", option:""),
                 "Weight" : (value:"0", type:"numeric", option:""),
                 "Gender" : (value:"0", type:"string", option:"male,female"),
                 "Activity Factor" : (value:"Bedridden",type:"string", option:actKeyString),
                 "Injury Factor" : (value:"Normal",type:"string", option:injuryKeyString),
                 "Carbohydrates" : (value:"70",type:"slider", option:""),
                 "Protein" : (value:"15",type:"slider", option:""),
                 "Fat" : (value:"15",type:"slider", option:"")
        ]
        
        output = ["BMI" : (value:"0", units:""),
                  "BMR" : (value:"0", units:"kcal/d"),
                  "TDEE" : (value:"0", units:"kcal/d"),
                  "Carbs" : (value:"0", units:"grams"),
                  "Proteins" : (value:"0", units:"grams"),
                  "Fats" : (value:"0", units:"grams")
        ]
    }
    
    func calculate(formula: String , input: [String : (value: String, type: String, option: String)]) {
        
        //Get Input Variables
        let age = Int((input["Age"]?.value)!)
        let height = Int((input["Height"]?.value)!)
        let weight = Int((input["Weight"]?.value)!)
        let gender = input["Gender"]?.value
        let activity = input["Activity Factor"]?.value
        let injury = input["Injury Factor"]?.value
        let carb = Float((input["Carbohydrates"]?.value)!)
        let prot = Float((input["Protein"]?.value)!)
        let fat = Float((input["Fat"]?.value)!)
        
        
        let bmiResult = bmi(height: height!, weight: weight!)
        
        //Calculate Basal Metabolic Rate
        var bmr:Float
        switch formula {
        case formulas[0]:
            bmr = hbe(age: age!, gender: gender!, height: height!, weight: weight!)
        case formulas[1]:
            bmr = hbe2(age: age!, gender: gender!, height: height!, weight: weight!)
        case formulas[2]:
            bmr = msj(age: age!, gender: gender!, height: height!, weight: weight!)
        default:
            bmr = 0.0
        }
        
        //Calculate Total Daily Energy Expenditure
        let tdeeResult = tdee(bmr: bmr, stressFactor: injuryFactors[injury!]!, activityFactor: activityFactors[activity!]!)
        let carbResult = carbs(tdee: tdeeResult, carbPercentage: carb!)
        let protResult = proteins(tdee: tdeeResult, proteinPercentage: prot!)
        let fatResult = fats(tdee: tdeeResult, fatPercentage: fat!)
        
        output["BMI"]?.value = String(bmiResult)
        output["BMR"]?.value = String(bmr)
        output["TDEE"]?.value = String(tdeeResult)
        output["Carbs"]?.value = String(carbResult)
        output["Proteins"]?.value = String(protResult)
        output["Fats"]?.value = String(fatResult)
    }
    
    func bmi(height: Int, weight: Int) -> Float {
        return Float(weight) / powf(Float(weight), 2.0)
    }
    
    func hbe(age: Int, gender: String, height: Int, weight: Int) -> Float{
        if(gender == "male") {
            let weightFactor:Float = 13.75 * Float(weight)
            let heightFactor:Float = 5.003 * Float(height)
            let ageFactor:Float = 6.755 * Float(age)
            return 66.5 + weightFactor + heightFactor - ageFactor
        } else {
            let weightFactor:Float = 9.563 * Float(weight)
            let heightFactor:Float = 1.850 * Float(height)
            let ageFactor:Float = 4.676 * Float(age)
            return 655.1 + weightFactor + heightFactor - ageFactor
        }
    }
    
    func hbe2(age: Int, gender: String, height: Int, weight: Int) -> Float{
        if(gender == "male") {
            let weightFactor:Float = 13.397 * Float(weight)
            let heightFactor:Float = 4.799 * Float(height)
            let ageFactor:Float = 5.677 * Float(age)
            return 88.362 + weightFactor + heightFactor - ageFactor
        } else {
            let weightFactor:Float = 9.247 * Float(weight)
            let heightFactor:Float = 3.098 * Float(height)
            let ageFactor:Float = 4.330 * Float(age)
            return 447.593 + weightFactor + heightFactor - ageFactor
        }
    }
    
    func msj(age: Int, gender: String, height: Int, weight: Int) -> Float{
        let weightFactor:Float = 10 * Float(weight)
        let heightFactor:Float = 6.25 * Float(height)
        let ageFactor:Float = 5 * Float(age)
        if(gender == "male") {
            return weightFactor + heightFactor - ageFactor + 5
        } else {
            return weightFactor + heightFactor - ageFactor - 161
        }
    }
    
    func tdee(bmr: Float, stressFactor: Float, activityFactor: Float) -> Float{
        return bmr*stressFactor*activityFactor
    }
    
    func carbs(tdee: Float, carbPercentage: Float) -> Float {
        return (tdee*carbPercentage)/Float(carbohydrate)
    }
    
    func proteins(tdee: Float, proteinPercentage: Float) -> Float {
        return (tdee*proteinPercentage)/Float(protein)
    }
    
    func fats(tdee: Float, fatPercentage: Float) -> Float {
        return (tdee*fatPercentage)/Float(fat)
    }
}
