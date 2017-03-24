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
import CSV
import CoreData

class PatientList: UITableViewController, UISearchResultsUpdating {
    
    var patients = Array<PatientInformation>()
    var filteredPatients = [PatientInformation]()
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    //Holder variable for new patients
    var newPatient : PatientInformation?
    
    
    //Getting managedContext to use coredata
    var managedContext : NSObject{
        get{
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            return appDelegate!.persistentContainer.viewContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filepath = Bundle.main.path(forResource: "cccs_cpg", ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filepath)
                let csv = try! CSV(
                    string: contents,
                    hasHeaderRow: true)
                for row in csv {
                    print(row[0])
                }
            } catch {
                print("File could not be loaded")
            }
        } else {
            print("File not found!")
        }
        
        self.fetchData()
        
        // Add search bar
        self.searchController = UISearchController(searchResultsController : self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //Show the list of patients when typing in the search bar
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        //Update the list
        self.searchController.searchResultsUpdater = self
       
        
    }
    
    func fetchData(){
        //fetch patient Information from Coredata
        print("call fetch method")
        let context = self.context
        let request : NSFetchRequest<PatientInformation> = PatientInformation.fetchRequest()
        
        do{
            self.patients = try (context?.fetch(request))! as [PatientInformation]
            for patient in patients{
                print("name :\(patient.name)")
                print("age :\(patient.age)")
            }
            
        }catch{
            let fetchError = error as NSError
            print(fetchError)
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //Filter through the Patients
        self.filteredPatients = self.patients.filter{(patient : PatientInformation) -> Bool in
            if (patient.name?.contains(self.searchController.searchBar.text!))!{
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
    
    // Click on the cell list --> carry index row and go to detail
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PInfo") as? PatientInfo {
            vc.selectedPatient = patients[indexPath.row]
            //self.performSegueWithIdentifier("SegueAdd", sender: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "List"
        navigationItem.backBarButtonItem = backItem
        // This will show in the next view controller being pushed
        /*
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        if let newPatientVC : PatientInfo = nav.viewControllers[0] as? PatientInfo {
            newPatientVC.updateClosure = {[weak self] patient in
                self?.fetchData()
                self?.tableView.reloadData()
            }
        }*/
    }
    
    
    // Delete Data
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let patientInfo = PatientInformation(context: context!)

        if editingStyle == .delete {
            //Using delete method from managedObjectContext
            patientInfo.managedObjectContext?.delete(patients[indexPath.row])
           do {
                //******
                try patientInfo.managedObjectContext?.save()
                patients.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
    }
    
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


