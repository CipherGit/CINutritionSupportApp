//
//  PatientInfo.swift
//  ICNutrition
//
//  Created by Justin Peña on 24/2/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

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
    
    @IBAction func saveButton(_ sender: Any) {
        let patient = Patient(name: pNameInput.text!, age: Int(ageInput.text!)!, gender: self.gender, height: Int(heightInput.text!)!, weight: Int(weightInput.text!)!, admittedDate: dateInput.text!, icuWard: icuInput.text!)
        self.updateClosure!(patient)
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
        pNameInput.text = patient.getName()
        ageInput.text = String(patient.getAge())
        if(patient.getGender() == "Male"){
            genderToggle.selectedSegmentIndex = 0
        }else{
            genderToggle.selectedSegmentIndex = 1
        }
        weightInput.text = String(patient.getWeight())
        heightInput.text = String(patient.getHeight())
        dateInput.text = String(patient.getAdmittedDate())
        icuInput.text = String(patient.getIcuWard())
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
