//
//  DynamicCalculatorVC.swift
//  ICNutrition
//
//  Created by Justin Peña on 19/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DynamicCalculatorVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedPatient : Patient?
    var selectedCalculator : Calculator?
    var calculatorInstance : CalculatorProtocol?
    var options : [String : [String]] = [:]
    
    var numericTextfield: [String : UITextField] = [:]
    var pickUI: [String : (UITextField, UIPickerView)] = [:]
    var segUI: [String : UISegmentedControl] = [:]
    var slidUI: [String : UISlider] = [:]
    var longestLabel : Int = 0

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
        let numericInputs  = input?.filter({$0.value.type=="numeric"})
        let numX = 16, numY=100, height = 40
        let screenWidth = UIScreen.main.bounds.width
        var currentstep = 0, latestY = 0, stepVal = 50
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
            
            //Find the longest label
            if(Int(label.frame.width) > longestLabel) {
                longestLabel = Int(label.frame.width)
            }
        }
        
        //Render all string input fields
        let stringInputs = input?.filter({$0.value.type=="string" && $0.value.option == ""})
        for (key, _) in stringInputs! {
            print(key)
        }
        
        //Render all segmented UI fields
        let segX = numX, segY=latestY + 25
        currentstep = 0
        let segUIInputs = input?.filter({$0.value.type=="string" && $0.value.option.components(separatedBy: ",").count == 2})
        for (key, value) in segUIInputs! {
            
            let label = UILabel(frame: CGRect(x: segX, y: segY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let valArr = value.option.components(separatedBy: ",")
            let customSC = UISegmentedControl(items: valArr)
            customSC.frame = CGRect(x: segX+Int(label.frame.width + 10), y: segY+currentstep-(height/4), width: Int(screenWidth - (CGFloat(numX) + label.frame.width + 25)), height: height)
            self.view.addSubview(customSC)
            currentstep += stepVal
            latestY = segY+currentstep-(height/4)
            
            segUI.updateValue(customSC, forKey: key)
            
            //Find the longest label
            if(Int(label.frame.width) > longestLabel) {
                longestLabel = Int(label.frame.width)
            }
        }
        
        //Render all picker fields
        let pickX = segX, pickY=latestY + 25
        currentstep = 0
        let pickerInputs = input?.filter({$0.value.type=="string" && $0.value.option.components(separatedBy: ",").count > 2})
        for (key, value) in pickerInputs! {
            let label = UILabel(frame: CGRect(x: pickX, y: pickY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let myTextField = UITextField(frame: CGRect(x: pickX+Int(label.frame.width + 10), y: pickY+currentstep-(height/4), width: Int(screenWidth - (CGFloat(pickX) + label.frame.width + 25)) , height: height))
            myTextField.borderStyle = UITextBorderStyle.roundedRect
            
            let customPicker = UIPickerView()
            customPicker.delegate = self
            customPicker.dataSource = self
            customPicker.backgroundColor = UIColor.white
            myTextField.inputView = customPicker
            
            self.view.addSubview(myTextField)
            currentstep += stepVal
            latestY = pickY+currentstep-(height/4)
            
            options.updateValue(value.option.components(separatedBy: ","), forKey: key)
            pickUI.updateValue((myTextField, customPicker), forKey: key)
            
            //Find the longest label
            if(Int(label.frame.width) > longestLabel) {
                longestLabel = Int(label.frame.width)
            }
        }
        
        //Render all slider fields
        let slidX = pickX, slidY=latestY + 25
        var extraStep = 20
        currentstep = 0; stepVal = 65
        let sliderInputs = input?.filter({$0.value.type=="slider"})
        for (key, _) in sliderInputs! {
            
            let label = UILabel(frame: CGRect(x: slidX, y: slidY+currentstep, width: 42, height: height))
            label.text = key + ":"
            label.numberOfLines=1
            label.sizeToFit()
            self.view.addSubview(label)
            
            let slider=UISlider(frame: CGRect(x: slidX+25, y: slidY+extraStep, width: Int(screenWidth*0.80) , height: height))
            slider.minimumValue = 0
            slider.maximumValue = 100
            
            self.view.addSubview(slider)
            currentstep += stepVal
            extraStep += stepVal
            latestY = pickY+currentstep-(height/4)
            
            slidUI.updateValue(slider, forKey: key)
            
            //Find the longest label
            if(Int(label.frame.width) > longestLabel) {
                longestLabel = Int(label.frame.width)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        for (key, value) in pickUI {
            if(value.1 == pickerView){
                return (options[key]?.count)!
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for (key, value) in pickUI {
            if(value.1 == pickerView){
                return (options[key]?[row])!
            }
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for (key, value) in pickUI {
            if(value.1 == pickerView){
                value.0.text = (options[key]?[row])!
            }
        }
        self.view.endEditing(true)
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

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
}