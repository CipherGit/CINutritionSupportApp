//
//  IcuTabController.swift
//  ICNutrition
//
//  Created by Justin Peña on 17/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class IcuTabController: UITabBarController {
    
    var selectedPatient : Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = selectedPatient?.name
        
        // Do any additional setup after loading the view.
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
