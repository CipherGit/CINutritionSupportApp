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
import CoreData

class PatientList: UITableViewController, UISearchResultsUpdating {
    
    var patients = Array<Patient>()
    var filteredPatients = [Patient]()
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    //Getting managedContext to use coredata
    var managedContext : NSObject{
        get{
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            return appDelegate!.persistentContainer.viewContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkPreload()
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

    func checkPreload(){
        let context = self.context
        let request : NSFetchRequest<Guideline> = Guideline.fetchRequest()
        do{
            let guidelines = try (context!.fetch(request)) as [Guideline]
            if guidelines.count <= 0 {
                let alert = UIAlertController(title: "Warning", message: "Guideline Database is Empty!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            NSLog("Guideline Preload Successful!")
        }catch{
            let fetchError = error as NSError
            NSLog(fetchError.localizedDescription)
        }
    }
    
    func fetchData(){
        let context = self.context
        let request : NSFetchRequest<Patient> = Patient.fetchRequest()
        do{
            self.patients = try (context!.fetch(request)) as [Patient]
            
        }catch{
            let fetchError = error as NSError
            print(fetchError)
        }
        print("in fetch data method")
        for patient1 in patients{
             print("name value value\(patient1.name)")
        }
       

        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //Filter through the Patients
        self.filteredPatients = self.patients.filter{(patient : Patient) -> Bool in
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
    }
    
    
    // Delete Data
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = self.context
        //let patientInfo = Patient(context: context!)

        if editingStyle == .delete {
            
            let patientTest = patients[indexPath.row]
            
            //Using delete method from managedObjectContext
            
            context?.delete(patientTest)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //patientInfo.managedObjectContext?.delete(patients[indexPath.row])
//            do {
//                //******
//                patients.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                try
//                    patientInfo.managedObjectContext?.save()
//            } catch {
//                let saveError = error as NSError
//                print(saveError)
//            }
            
         fetchData()
         self.tableView.reloadData()
        
        }
       
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


