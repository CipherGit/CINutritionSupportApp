//
//  DynamicCalculatorVC.swift
//  ICNutrition
//
//  Created by Justin Peña on 19/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DynamicCalculatorVC: UIViewController {
    
    var selectedPatient : Patient?
    var selectedCalculator : Calculator?
    var calculatorInstance : CalculatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedPatient = (tabBarController as! IcuTabController).selectedPatient
        
        //Log the calculator received
        NSLog("Calculator Name: %@", selectedCalculator?.calcName ?? "No Calculator")
        
        //Instantiate specified calculator
        switch (selectedCalculator?.calcName)! {
        case "Caloric Requirements":
            calculatorInstance = CaloricRequirementCalculator()
        default:
            NSLog("No Calculator Loaded!")
        }
        
        //Create UI Based on the calculator
        let input = calculatorInstance?.input
        
        //Render all numeric input fields
        var numericTextfield: [String : UITextField] = [:]
        let numericInputs  = input?.filter({$0.value.type=="numeric"})
        let numX = 16, numY=100, stepVal = 50, height = 40
        let screenWidth = UIScreen.main.bounds.width
        var currentstep = 0, latestY = 0
        for (key, _) in numericInputs! {
            let label = UILabel(frame: CGRect(x: numX, y: numY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let myTextField = UITextField(frame: CGRect(x: numX+Int(label.frame.width + 10), y: numY+currentstep-(height/4), width: Int(screenWidth - (CGFloat(numX) + label.frame.width + 25)) , height: height))
            myTextField.borderStyle = UITextBorderStyle.roundedRect
            myTextField.keyboardType = .numberPad
            self.view.addSubview(myTextField)
            
            numericTextfield.updateValue(myTextField, forKey: key)
            currentstep += stepVal
            latestY = numY+currentstep-(height/4)
        }
        
        //Render all string input fields
        let stringInputs = input?.filter({$0.value.type=="string" && $0.value.option == ""})
        for (key, _) in stringInputs! {
            print(key)
        }
        
        //Render all segmented UI fields
        var segUI: [String : UISegmentedControl] = [:]
        let segX = numX, segY=latestY + 25
        currentstep = 0
        let segUIInputs = input?.filter({$0.value.type=="string" && $0.value.option.components(separatedBy: " ").count == 2})
        for (key, value) in segUIInputs! {
            let label = UILabel(frame: CGRect(x: segX, y: segY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let valArr = value.option.components(separatedBy: " ")
            let customSC = UISegmentedControl(items: valArr)
            customSC.frame = CGRect(x: segX+Int(label.frame.width + 10), y: segY+currentstep-(height/4), width: Int(screenWidth - (CGFloat(numX) + label.frame.width + 25)), height: height)
            self.view.addSubview(customSC)
            currentstep += stepVal
            latestY = segY+currentstep-(height/4)
            
            segUI.updateValue(customSC, forKey: key)
        }
        
        //Render all picker fields
        var pickUI: [String : (UITextField, UIPickerView)] = [:]
        let pickX = segX, pickY=latestY + 25
        currentstep = 0
        let pickerInputs = input?.filter({$0.value.type=="string" && $0.value.option.components(separatedBy: " ").count > 2})
        for (key, _) in pickerInputs! {
            let label = UILabel(frame: CGRect(x: pickX, y: pickY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let myTextField = UITextField(frame: CGRect(x: pickX+Int(label.frame.width + 10), y: pickY+currentstep-(height/4), width: Int(screenWidth - (CGFloat(pickX) + label.frame.width + 25)) , height: height))
            myTextField.borderStyle = UITextBorderStyle.roundedRect
            
            let customPicker = UIPickerView()
            myTextField.inputView = customPicker
            
            self.view.addSubview(myTextField)
            currentstep += stepVal
            latestY = pickY+currentstep-(height/4)
            
            pickUI.updateValue((myTextField, customPicker), forKey: key)
        }
        
        //Render all slider fields
        var slidUI: [String : UISlider] = [:]
        let slidX = pickX, slidY=latestY + 25
        currentstep = 0
        let sliderInputs = input?.filter({$0.value.type=="slider"})
        for (key, _) in sliderInputs! {
            let label = UILabel(frame: CGRect(x: slidX, y: slidY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let slider=UISlider(frame: CGRect(x: slidX+Int(label.frame.width + 10), y: slidY+currentstep-(height/4), width: Int(screenWidth - (CGFloat(slidX) + label.frame.width + 25)) , height: height))
            slider.minimumValue = 0
            slider.maximumValue = 100
            
            self.view.addSubview(slider)
            currentstep += stepVal
            latestY = pickY+currentstep-(height/4)
            
            slidUI.updateValue(slider, forKey: key)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
