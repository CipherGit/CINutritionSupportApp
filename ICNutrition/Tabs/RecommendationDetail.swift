//
//  RecommendationDetail.swift
//  ICNutrition
//
//  Created by Justin Peña on 20/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class RecommendationDetail: UIViewController {
    
    var guideline : Guideline?
    @IBOutlet weak var glShortHand: UILabel!
    @IBOutlet weak var glContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.title = (guideline?.identifier)! + " " + (guideline?.glToOne_GLSource?.glName)!
        glShortHand.text = guideline?.shortDesc
        glShortHand.sizeToFit()
        glContent.text = guideline?.fullDesc
        glContent.sizeToFit()
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
