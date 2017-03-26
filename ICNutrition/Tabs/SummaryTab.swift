//
//  SummaryTab.swift
//  ICNutrition
//
//  Created by lijinjin on 21/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class SummaryTab: UIViewController {

    @IBOutlet weak var Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tabBarController?.navigationItem.title = "Patient Name"
        /*
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Guideline Recommendations", attributes: underlineAttribute)
        Label.attributedText = underlineAttributedString*/
        
        
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
