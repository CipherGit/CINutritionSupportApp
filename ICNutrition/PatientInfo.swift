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
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let patientInfo = Patient(context: context!)
        if selectedPatient != nil {
            selectedPatient?.name = self.pNameInput.text
            let ageString = ageInput.text!
            selectedPatient?.age = Int16(ageString)!
            selectedPatient?.gender = self.gender
            selectedPatient?.height = Int16(heightInput.text!)!
            selectedPatient?.weight = Int16(weightInput.text!)!
            selectedPatient?.date = dateInput.text
            selectedPatient?.icuward = icuInput.text
            
            do{
                try selectedPatient?.managedObjectContext?.save()
                //self.updateClosure!()
                self.navigationController?.dismiss(animated: true, completion: nil)
                
            } catch {
                print("Error here")
            }
            
        }
        else{
            patientInfo.name = self.pNameInput.text
            let ageString = ageInput.text!
            patientInfo.age = Int16(ageString)!
            patientInfo.gender = self.gender
            patientInfo.height = Int16(heightInput.text!)!
            patientInfo.weight = Int16(weightInput.text!)!
            patientInfo.date = dateInput.text
            patientInfo.icuward = icuInput.text
            do{
                try patientInfo.managedObjectContext?.save()
                self.updateClosure!(patientInfo)
                self.navigationController?.dismiss(animated: true, completion: nil)
                
            } catch {
                print("Error here")
            }
        }
        
        
        self.navigationController?.dismiss(animated: true, completion: nil)
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
        self.icuInput.keyboardType = .numberPad
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
        pNameInput.text = patient.name
        ageInput.text = String(patient.age)
        if(patient.gender == "Male"){
            genderToggle.selectedSegmentIndex = 0
        }else{
            genderToggle.selectedSegmentIndex = 1
        }
        weightInput.text = String(patient.weight)
        heightInput.text = String(patient.height)
        dateInput.text = patient.date
        icuInput.text = patient.icuward
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pNameInput.resignFirstResponder()
        ageInput.resignFirstResponder()
        weightInput.resignFirstResponder()
        heightInput.resignFirstResponder()
        icuInput.resignFirstResponder()
        dateInput.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "List"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }*/
    
}
