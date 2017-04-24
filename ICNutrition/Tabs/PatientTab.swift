//
//  PatientTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class PatientTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var patient : Patient?
    var patientInformation : [String]!
    var patientLabel : [String]!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabCont = self.tabBarController  as! IcuTabController
        patient = tabCont.selectedPatient
        
        patientLabel = ["Name","Gender","Age","Weight","Height","ICU Ward"]
        
        let  name = patient?.name
        let gender = patient?.gender
        let age = String(describing: patient!.age)
        
        let weightText = String(describing: patient!.weight)
        let heightText = String(describing: patient!.height)
        
        let icuWardText = patient!.patientToOne_Ward?.wardName
        
        patientInformation = [name!, gender!, age, weightText, heightText,icuWardText!]
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.patientInformation.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "ElementCell")
        
        //Non clickable
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        //Deleting the line 
    
        
        cell.textLabel?.text = self.patientLabel[indexPath.row]
        
        
        cell.detailTextLabel?.text = self.patientInformation[indexPath.row]
        return cell
    
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
