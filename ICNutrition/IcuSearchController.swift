//
//  IcuSearchController.swift
//  ICNutrition
//
//  Created by Justin Peña on 17/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class IcuSearchController: UISearchController {
    
    public var icuSearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public var searchBar: UISearchBar {
        get {
            return icuSearchBar
        }
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
