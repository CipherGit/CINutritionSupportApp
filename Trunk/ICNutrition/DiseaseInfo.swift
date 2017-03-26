//
//  DiseaseInfo.swift
//  ICNutrition
//
//  Created by lijinjin on 14/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DiseaseInfo: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    var tableRow: Int?
    var disease: Disease?
    var diseases = Array<Disease>()
    var diseaseList = ["Burn","Trauma","Liver Disease"]
    var severityLevelList = ["Acute","Mild", "Moderate"]
    
    @IBOutlet weak var dNameTextField: UITextField!
    @IBOutlet weak var dNameInput: UITextField!
    @IBOutlet weak var severityLevelInput: UITextField!
    @IBOutlet weak var notesInput: UITextView!
    
    @IBOutlet weak var diseaseTableView: UITableView!
    
    @IBOutlet weak var dNameDropdown: UIPickerView!
    
    @IBOutlet weak var severityLevelDropdown: UIPickerView!
    
    @IBAction func addButton(_ sender: UIButton) {
        disease = Disease(diseaseName: dNameInput.text!, severityLevel: severityLevelInput.text!, notes: notesInput.text!)
        diseases.append(disease!)
        diseaseTableView.reloadData()
    }
    
    @IBAction func removeButton(_ sender: UIButton) {
        diseases.remove(at: tableRow!)
        diseaseTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dNameDropdown.isHidden = true
        severityLevelDropdown.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (diseases.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        /*
         let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
         cell.textLabel?.text = diseases[indexPath.row]
         return cell;*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! DiseaseTableViewCell
        cell.diseaseLabel.text = diseases[indexPath.row].getDiseaseName()
        cell.severityLabel.text = diseases[indexPath.row].getSeverityLevel()
        cell.notesLabel.text = diseases[indexPath.row].getNotes()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableRow = indexPath.row
    }
    
    ///////////////////////
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dNameInput.resignFirstResponder()
        severityLevelInput.resignFirstResponder()
        notesInput.resignFirstResponder()
        
    }
    
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
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.dNameTextField){
            self.dNameDropdown.isHidden = false
            textField.endEditing(true)
        }
        else if(textField == self.severityLevelInput){
            self.severityLevelDropdown.isHidden = false
            textField.endEditing(true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "List"
        navigationItem.backBarButtonItem = backItem
        
        
        // This will show in the next view controller being pushed
        
    }
    
    
}
