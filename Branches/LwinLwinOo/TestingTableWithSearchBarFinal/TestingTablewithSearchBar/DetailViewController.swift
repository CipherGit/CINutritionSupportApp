//
//  DetailViewController.swift
//  TestingTablewithSearchBar
//
//  Created by LwinLwin Oo on 22/2/17.
//  Copyright © 2017 LwinLwin Oo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var patientNameData: UILabel!
    
    var patientNameString : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.patientNameData.text = self.patientNameString
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
