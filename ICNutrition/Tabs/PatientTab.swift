//
//  PatientTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class PatientTab: UIViewController {
    
    var patient : Patient?
    
    
    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var genderText: UILabel!
    
    @IBOutlet weak var ageText: UILabel!
    
    
    @IBOutlet weak var weightText: UILabel!
    
    @IBOutlet weak var heightText: UILabel!
    
    
    @IBOutlet weak var admittedDate: UILabel!
    
    @IBOutlet weak var icuWardText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addTapped))
        
        print("In the patient Tab")
        print("Patient name \(patient?.name)")
        
        nameText.text = patient?.name
        genderText.text = patient?.gender
        ageText.text = String(describing: patient!.age)
        
        weightText.text! = String(describing: patient!.weight)
        
        heightText.text! = String(describing: patient!.height)
        
        icuWardText.text = String(describing: patient!.patientToOne_Ward)

        // Do any additional setup after loading the view.
    }
    
    func addTapped(){
        print("tapped here")
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
