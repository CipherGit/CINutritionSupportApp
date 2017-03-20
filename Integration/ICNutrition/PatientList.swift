//
//  ViewController.swift
//  ICNutrition
//
//  Created by Justin Peña on 24/2/17.
//  Integrated from TestingTableViewController.swift by Lwin Lwin Oo
//
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class PatientList: UITableViewController, UISearchResultsUpdating {
    
    var patients = Array<Patient>()
    var filteredPatients = [Patient]()
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    //Holder variable for new patients
    var newPatient : Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let patient1 = Patient(name: "Alice", age: 56, gender: "Female", height: 162, weight: 65, admittedDate: "2/12/2017, 12:34 PM", icuWard: "North Wing")
        let patient2 = Patient(name: "Bob", age: 32, gender: "Male", height: 150, weight: 43, admittedDate: "2/12/2017, 12:34 PM", icuWard: "North Wing")
        let patient3 = Patient(name: "Cherry", age: 43, gender: "Female", height: 140, weight: 60, admittedDate: "2/12/2017, 12:34 PM", icuWard: "North Wing")
        patients.append(patient1)
        patients.append(patient2)
        patients.append(patient3)
        
        //Update patients array
        if (newPatient != nil){
            self.patients += [newPatient!]
        }
        
        // Add search bar
        self.searchController = UISearchController(searchResultsController : self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //Show the list of patients when typing in the search bar
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        //Update the list
        self.searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //Filter through the Patients
        self.filteredPatients = self.patients.filter{(patient : Patient) -> Bool in
            if patient.name.contains(self.searchController.searchBar.text!){
                return true
            }
            else {
                return false
            }
        }
        
        //Update the results TableView
        self.resultsController.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return self.patients.count
        }
        else {
            return self.filteredPatients.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == self.tableView {
            cell.textLabel?.text = self.patients[indexPath.row].name
        }
        else {
            cell.textLabel?.text = self.filteredPatients[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PInfo") as? PatientInfo {
            vc.selectedPatient = patients[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        if let newPatientVC : PatientInfo = nav.viewControllers[0] as? PatientInfo {
            newPatientVC.updateClosure = {[weak self] patient in
                self?.patients.append(patient)
                self?.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

