//
//  DiseaseInfo.swift
//  ICNutrition
//
//  Created by lijinjin on 14/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DiseaseInfo: UIViewController, UITableViewDataSource, UITableViewDelegate,  UITextFieldDelegate{
    
    var tableRow: Int?
    var disease: Disease?
    var diseases = Array<Disease>()
    
    var updateClosure:((_ patient : Patient)->Void)?
    
    //Carry Patient Data 
    var insertedPatient : Patient?
    
    
    @IBOutlet weak var removebtn: UIButton!
    @IBOutlet weak var addbtn: UIButton!
    //@IBOutlet weak var addbtn: UIButton!
    //@IBOutlet weak var removebtn: UIButton!
    
    @IBOutlet weak var dNameTextField: UITextField!
    @IBOutlet weak var dNameInput: UITextField!
    @IBOutlet weak var severityLevelInput: UITextField!
    @IBOutlet weak var notesInput: UITextView!
    
    @IBOutlet weak var diseaseTableView: UITableView!
    
    @IBAction func addButton(_ sender: UIButton) {
        //disease = Disease(diseaseName: dNameInput.text!, severityLevel: severityLevelInput.text!, notes: notesInput.text!)
        //diseases.append(disease!)
        //diseaseTableView.reloadData()
        
        disease = Disease(context: context!)
        disease?.diseaseName = dNameTextField.text
        disease?.diseaseSeverity = severityLevelInput.text
        disease?.diseaseNotes = notesInput.text
        disease?.disToOne_Patient = insertedPatient
        
        do{
            try disease?.managedObjectContext?.save()
        } catch {
            print("Error here")
        }
        diseases.append(disease!)
        diseaseTableView.reloadData()
        
        dNameTextField.text=""
        severityLevelInput.text=""
        notesInput.text=""
    }
    
    @IBAction func removeButton(_ sender: UIButton) {
        diseaseTableView.reloadData()
        
        let diseaseInfo = Disease(context: context!)
        diseaseInfo.managedObjectContext?.delete(diseases[tableRow!])
        do {
            try diseaseInfo.managedObjectContext?.save()
            diseases.remove(at: tableRow!)
            diseaseTableView.reloadData()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(insertedPatient == nil){
            insertedPatient = (tabBarController as! IcuTabController).selectedPatient
        }
        print ("name :\(insertedPatient?.name)")
        diseases = insertedPatient?.patientToMany_Disease?.allObjects as! [Disease]
        notesInput!.layer.borderWidth = 0.5
        notesInput!.layer.borderColor = UIColor.init(red: 213.0/255.0, green: 213.0/255.0, blue: 213.0/255.0, alpha: 1).cgColor

        
        addbtn.backgroundColor = UIColor.init(red: 21.0/255.0, green: 126.0/255.0, blue: 251.0/255.0, alpha: 1)
        removebtn.backgroundColor = UIColor.init(red: 21.0/255.0, green: 126.0/255.0, blue: 251.0/255.0, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (diseases.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! DiseaseTableViewCell
        cell.diseaseLabel.text = diseases[indexPath.row].diseaseName
        cell.severityLabel.text = diseases[indexPath.row].diseaseSeverity
        cell.notesLabel.text = diseases[indexPath.row].diseaseNotes
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableRow = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let diseaseInfo = Disease(context: context!)
        if editingStyle == .delete {
            diseaseInfo.managedObjectContext?.delete(diseases[tableRow!])
            do {
                try diseaseInfo.managedObjectContext?.save()
                diseases.remove(at: tableRow!)
                diseaseTableView.reloadData()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dNameInput.resignFirstResponder()
        severityLevelInput.resignFirstResponder()
        notesInput.resignFirstResponder()
    }
    
    /*
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = diseaseList.count
        if (pickerView == severityLevelDropdown) {
            countrows = severityLevelList.count
        }
        return countrows
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == dNameDropdown){
            let titleRow = diseaseList[row]
            return titleRow
        }
        else if pickerView == severityLevelDropdown{
            let titleRow = severityLevelList[row]
            return titleRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == dNameDropdown){
            self.dNameInput.text = self.diseaseList[row]
            self.dNameDropdown.isHidden = true
        }
        else if pickerView == severityLevelDropdown{
            self.severityLevelInput.text = self.severityLevelList[row]
            self.severityLevelDropdown.isHidden = true
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        let backItem = UIBarButtonItem()
        backItem.title = "List"
        navigationItem.backBarButtonItem = backItem*/
        /*
        let view = segue.destination as! UITabBarController
        let controller = view.viewControllers![1] as! PatientTab
        controller.patient = insertedPatient*/
        
        let backItem = UIBarButtonItem()
        backItem.title = "List"
        navigationItem.backBarButtonItem = backItem
        
        insertedPatient?.patientToMany_Disease?.adding(diseases)
       
        do{
            try insertedPatient?.managedObjectContext?.save()
        } catch {
            print("Error here")
        }
        let tabCtrl = segue.destination as! IcuTabController
        tabCtrl.selectedPatient = self.insertedPatient
  


    }
    
    
}
