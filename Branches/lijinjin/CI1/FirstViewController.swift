//
//  FirstViewController.swift
//  CI1
//
//  Created by lijinjin on 21/2/17.
//  Copyright © 2017 lijinjin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate{
    
    var name = "", age = "", gender = "Male", weight = "", height = "", admittedDate = "", nutriScore = ""
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var admittedDateText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var nutriScoreText: UITextField!
    
    @IBAction func genderToggle(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            self.gender = "Male"
        }else{
            self.gender = "Female"
        }
        
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        self.name = nameText.text!
        self.age = ageText.text!
        self.weight = weightText.text!
        self.height = heightText.text!
        self.admittedDate = admittedDateText.text!
        self.nutriScore = nutriScoreText.text!
        
        print(name)
        print(age)
        print(gender)
        print(weight)
        print(height)
        print(admittedDate)
        print(nutriScore)
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

