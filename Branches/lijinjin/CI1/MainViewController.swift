//
//  MainViewController.swift
//  CI1
//
//  Created by lijinjin on 22/2/17.
//  Copyright © 2017 lijinjin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var patientInfo = Patient(name: "Alice", age: 56, gender: "Female", height: 162, weight: 65, admittedDate: "2/12/2017, 12:34 PM", nutriScore: 2) 
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : FirstViewController = segue.destination as! FirstViewController
        DestViewController.patientInfo = self.patientInfo
    }
    

}
