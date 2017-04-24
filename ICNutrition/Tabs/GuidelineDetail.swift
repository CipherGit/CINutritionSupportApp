//
//  GuidelineDetail.swift
//  ICNutrition
//
//  Created by Justin Peña on 20/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class GuidelineDetail: UIViewController {
    
    var guideline : Guideline?
    
    @IBOutlet weak var glContent: UILabel!
    @IBOutlet weak var glShorthand: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarController?.navigationItem.title = (guideline?.identifier)! + " " + (guideline?.glToOne_GLSource?.glName)!
        glShorthand.text = guideline?.shortDesc
        glContent.text = guideline?.fullDesc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
