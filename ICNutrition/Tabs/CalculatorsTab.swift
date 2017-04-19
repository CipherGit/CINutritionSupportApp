//
//  CalculatorsTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class CalculatorsTab: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var calculators = [Calculator]()
    var filteredCalculators = [Calculator]()

    @IBOutlet weak var calcTable: UITableView!
    @IBOutlet weak var calcSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Temporarily Create a Calculator Object
        let calc = Calculator(context: context!)
        calc.calcID = 1
        calc.calcName = "Caloric Requirements"
        
        calculators.append(calc)
        
        calcTable.delegate = self
        calcTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.calculators.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calcCell", for: indexPath)
        cell.textLabel?.text = self.calculators[indexPath.row].calcName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "calcSegue", sender: calculators[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "calcSegue"){
            let dynamicCalc = segue.destination as! DynamicCalculatorVC
            dynamicCalc.selectedCalculator = sender as? Calculator
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
