//
//  CalculatorProtocol.swift
//  ICNutrition
//
//  Created by Justin Peña on 18/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import Foundation

protocol CalculatorProtocol {
    var formulas : [String] { get }
    var input : [String : (value: String, type: String, option: String)] { get set }
    var output : [String : (value: String, units: String)] { get set }
    
    func calculate(formula: String, input: [String:(value: String, type: String, option: String)])
}
