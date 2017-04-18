//
//  CalculatorsTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class CalculatorsTab: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var calculator = Array<String>()
    var filteredCalculator = [Calculator]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator = ["Calcoric calculation"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.calculator.count
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
            cell.textLabel?.text = self.calculator[indexPath.row]
        
        return cell
    }
    
    // Click on the cell list --> carry index row and go to detail
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: calculator[indexPath.row])
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
