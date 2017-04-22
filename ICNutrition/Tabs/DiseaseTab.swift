//
//  DiseaseTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DiseaseTab: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    var selectedPatient : Patient?
    var disease: Disease?
    var diseases = Array<Disease>()
    //@IBOutlet weak var diseaseTableView: UITableView!
    
    @IBOutlet weak var diseaseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedPatient = (tabBarController as! IcuTabController).selectedPatient
        self.tabBarController?.navigationItem.title = selectedPatient?.name
        
        diseases = selectedPatient?.patientToMany_Disease?.allObjects as! [Disease]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (diseases.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        /*
         let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
         cell.textLabel?.text = diseases[indexPath.row]
         return cell;*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1",for: indexPath) as! DiseaseTableViewCell
        cell.diseaseLabel.text = diseases[indexPath.row].diseaseName
        cell.severityLabel.text = diseases[indexPath.row].diseaseSeverity
        cell.notesLabel.text = diseases[indexPath.row].diseaseNotes
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableRow = indexPath.row
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
