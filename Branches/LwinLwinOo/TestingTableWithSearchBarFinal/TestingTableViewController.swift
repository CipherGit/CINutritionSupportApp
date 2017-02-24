//
//  TestingTableViewController.swift
//  TestingTablewithSearchBar
//
//  Created by LwinLwin Oo on 22/2/17.
//  Copyright © 2017 LwinLwin Oo. All rights reserved.
//

import UIKit

class TestingTableViewController: UITableViewController , UISearchResultsUpdating{
    
    var patients = Array<String>()
    
    var filteredPatients = [String]()
    
    var searchController : UISearchController!
    //Adding search bar
    var resultsController = UITableViewController()
    
    //Recevieing the passed data 
    var stringPassed = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize String
        //self.patients += ["John"]
        //self.patients += ["Mary"]
                
        
        //Adding patient name to the patient 
        print(stringPassed)
        
        if (stringPassed != ""){
            self.patients += [stringPassed]
        }
        
        //show the lists of patients when type in the search bar
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        // Adding search bar
        self.searchController = UISearchController(searchResultsController : self.resultsController)
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //Update the list
        self.searchController.searchResultsUpdater = self

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //Filter through the Patients
        self.filteredPatients = self.patients.filter{(patient : String) -> Bool in
        // If find search items in the patients list, return that specific patient
            if patient.contains(self.searchController.searchBar.text!){
                return true
            }
            else {
                return false
            }
            
        }
    
        //Update the results TableView
        self.resultsController.tableView.reloadData()
    
    }

       // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == self.tableView{
            return self.patients.count
        }
        else {
            return self.filteredPatients.count
        }
        
    }

    //override function of tableview controller 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if tableView == self.tableView {
            cell.textLabel?.text = self.patients[indexPath.row]
        }
        else {
           cell.textLabel?.text = self.filteredPatients[indexPath.row]
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as? UINavigationController
        if let newPatientVC : AddScreenViewController = navController?.visibleViewController as? AddScreenViewController  {
            newPatientVC.updateClosure = {[weak self] name in
                self?.patients.append(name)
                self?.tableView.reloadData()
            }
        }
    }

}

