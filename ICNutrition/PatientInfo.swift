//
//  PatientInfo.swift
//  ICNutrition
//
//  Created by Justin Peña on 24/2/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit
import CoreData

class PatientInfo: UIViewController {
    
    let datePicker = UIDatePicker()
    
    var gender = "Male"
    var selectedPatient : Patient?
    var updateClosure:((_ patient : Patient)->Void)?
    
    
    var patientInfo : Patient? = nil
    
    let dateFormatter = DateFormatter()
    
    
    @IBOutlet weak var pNameInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var icuInput: UITextField!
    @IBOutlet weak var genderToggle: UISegmentedControl!
    
    @IBAction func genderToggleInput(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            self.gender = "Male"
        }else{
            self.gender = "Female"
        }
    }
    
    //get managedContext to use coredata
    var managedContext : NSObject{
        get{
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            return appDelegate!.persistentContainer.viewContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedPatient != nil {
            fillFromPatient(patient: selectedPatient!)
        }
        
        createDatePicker()
        
        self.ageInput.keyboardType = .numberPad
        self.weightInput.keyboardType = .numberPad
        self.heightInput.keyboardType = .numberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton=UIBarButtonItem(barButtonSystemItem: .done, target:nil, action:#selector(donePressed))
        toolbar.setItems([doneButton],animated:false)
        dateInput.inputAccessoryView=toolbar
        dateInput.inputView=datePicker
    }
    
    func donePressed(){
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateInput.text=dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func fillFromPatient(patient:Patient) {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        pNameInput.text = patient.name
        ageInput.text = String(patient.age)
        if(patient.gender == "Male"){
            genderToggle.selectedSegmentIndex = 0
        }else{
            genderToggle.selectedSegmentIndex = 1
        }
        weightInput.text = String(patient.weight)
        heightInput.text = String(patient.height)
        dateInput.text = dateFormatter.string(from: patient.admitDate! as Date)
        icuInput.text = patient.patientToOne_Ward?.wardName!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pNameInput.resignFirstResponder()
        ageInput.resignFirstResponder()
        weightInput.resignFirstResponder()
        heightInput.resignFirstResponder()
        icuInput.resignFirstResponder()
        dateInput.resignFirstResponder()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let check = validate()
        if(check == false){
            return false
        }
        else{
            if selectedPatient != nil {
                selectedPatient?.name = self.pNameInput.text
                let ageString = ageInput.text!
                selectedPatient?.age = Int16(ageString)!
                selectedPatient?.gender = self.gender
                selectedPatient?.height = Int16(heightInput.text!)!
                selectedPatient?.weight = Int16(weightInput.text!)!
                selectedPatient?.admitDate = dateFormatter.date(from: dateInput.text!)! as NSDate?
                
                let newWard = ICUWard(context: context!)
                newWard.wardName = icuInput.text
                selectedPatient?.patientToOne_Ward = newWard
                
                do{
                    try newWard.managedObjectContext?.save()
                    try selectedPatient?.managedObjectContext?.save()
                } catch {
                    print("Error here edit")
                }
                
            }else{
                patientInfo = Patient(context: context!)
                patientInfo?.name = self.pNameInput.text
                let ageString = ageInput.text!
                patientInfo?.age = Int16(ageString)!
                patientInfo?.gender = self.gender
                patientInfo?.height = Int16(heightInput.text!)!
                patientInfo?.weight = Int16(weightInput.text!)!
                patientInfo?.admitDate = dateFormatter.date(from: dateInput.text!)! as NSDate?
                
                let newWard = ICUWard(context: context!)
                newWard.wardName = icuInput.text
                patientInfo?.patientToOne_Ward = newWard
                
                do{
                    try newWard.managedObjectContext?.save()
                    try patientInfo?.managedObjectContext?.save()
                } catch {
                    print("Error here insert")
                }
                
            }
            return true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : DiseaseInfo = segue.destination as! DiseaseInfo
        DestViewController.insertedPatient = patientInfo
        let backItem = UIBarButtonItem()
        backItem.title = "Patient"
        navigationItem.backBarButtonItem = backItem
        
    }
    
    //Validation Start
    func validate() -> Bool {
        var valid: Bool = true
        if (pNameInput.text?.isEmpty)! {
            pNameInput.attributedPlaceholder = NSAttributedString(string: "Please Enter Patient Name", attributes: [NSForegroundColorAttributeName: UIColor.red])
            valid = false
        }
        if (ageInput.text?.isEmpty)! {
            ageInput.attributedPlaceholder = NSAttributedString(string: "Please Enter Age", attributes: [NSForegroundColorAttributeName: UIColor.red])
            valid = false
        }
        if (heightInput.text?.isEmpty)! {
            heightInput.attributedPlaceholder = NSAttributedString(string: "Please Enter Height", attributes: [NSForegroundColorAttributeName: UIColor.red])
            valid = false
        }
        if (weightInput.text?.isEmpty)! {
            weightInput.attributedPlaceholder = NSAttributedString(string: "Please Enter Weight", attributes: [NSForegroundColorAttributeName: UIColor.red])
            valid = false
        }
        if (dateInput.text?.isEmpty)! {
            dateInput.attributedPlaceholder = NSAttributedString(string: "Please Enter Date", attributes: [NSForegroundColorAttributeName: UIColor.red])
            valid = false
        }
        if (icuInput.text?.isEmpty)! {
            icuInput.attributedPlaceholder = NSAttributedString(string: "Please Enter ICU Ward", attributes: [NSForegroundColorAttributeName: UIColor.red])
            valid = false
        }
        return valid
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }*/
    
}
