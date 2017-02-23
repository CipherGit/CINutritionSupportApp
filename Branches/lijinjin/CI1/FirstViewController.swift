//
//  FirstViewController.swift
//  CI1
//
//  Created by lijinjin on 21/2/17.
//  Copyright © 2017 lijinjin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate{
    
 /*   var name = "", age = "", gender = "Male", weight = "", height = "", admittedDate = "", nutriScore = ""*/
    var gender = "Male"
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var admittedDateText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var nutriScoreText: UITextField!
    @IBOutlet weak var genderToggle: UISegmentedControl!
    
    var patientInfo: Patient!
   
/*
    @IBAction func genderToggle(_ sender: UISegmentedControl) {
        /*
        if (sender.selectedSegmentIndex == 0){
            self.gender = "Male"
        }else{
            self.gender = "Female"
        }*/
        
        if (patientInfo.getGender() == "Male"){
            sender.selectedSegmentIndex = 0
        }else{
            sender.selectedSegmentIndex = 1
        }
        
    }*/
    

    @IBAction func nextBtn(_ sender: Any) {
        /*
        self.name = nameText.text!
        self.age = ageText.text!
        self.weight = weightText.text!
        self.height = heightText.text!
        self.admittedDate = admittedDateText.text!
        self.nutriScore = nutriScoreText.text!*/
        
    /*    let patientInfo = Patient(name: nameText.text!, age: Int(ageText.text!)!, gender: self.gender, height: Int(heightText.text!)!, weight: Int(weightText.text!)!, admittedDate: admittedDateText.text!, nutriScore: Int(nutriScoreText.text!)!)*/
        
    /*
        print(patientInfo.name)
        print(patientInfo.age)
        print(patientInfo.gender)
        print(patientInfo.weight)
        print(patientInfo.height)
        print(patientInfo.admittedDate)
        print(patientInfo.nutriScore)*/
    }
    
    @IBAction func backBtn(_ sender: Any) {
    }
    
    let datePicker=UIDatePicker()
    
    func createDatePicker(){
        
        //FORMAT
        datePicker.datePickerMode = .dateAndTime//.date
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton=UIBarButtonItem(barButtonSystemItem: .done, target:nil,action:#selector(donePressed))
        toolbar.setItems([doneButton],animated:false)
        
        admittedDateText.inputAccessoryView=toolbar
        admittedDateText.inputView=datePicker
    }
    
    func donePressed(){
        //format date
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short//.none
      //       admittedDateText.text="\(datePicker.date)"
        admittedDateText.text=dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameText.resignFirstResponder()
        ageText.resignFirstResponder()
        weightText.resignFirstResponder()
        heightText.resignFirstResponder()
        nutriScoreText.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameText.text = patientInfo.getName()
        ageText.text = String(patientInfo.getAge())
        if(patientInfo.getGender() == "Male"){
            genderToggle.selectedSegmentIndex = 0
        }else{
            genderToggle.selectedSegmentIndex = 2
        }
        weightText.text = String(patientInfo.getWeight())
        heightText.text = String(patientInfo.getHeight())
        admittedDateText.text = String(patientInfo.getAdmittedDate())
        nutriScoreText.text = String(patientInfo.getNutriScore())
        
        createDatePicker()
        
        self.ageText.keyboardType = .numberPad
        self.weightText.keyboardType = .numberPad
        self.heightText.keyboardType = .numberPad
        self.nutriScoreText.keyboardType = .numberPad
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

