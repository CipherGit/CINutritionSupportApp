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
<<<<<<< HEAD

class PatientList: UITableViewController, UISearchResultsUpdating {
    
    var patients = Array<Patient>()
    var filteredPatients = [Patient]()
=======
import CoreData

class PatientList: UITableViewController, UISearchResultsUpdating {
    
    var patients = Array<PatientInformation>()
    var filteredPatients = [PatientInformation]()
>>>>>>> parent of 42da85d... Clean Up Repository
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    //Holder variable for new patients
<<<<<<< HEAD
    var newPatient : Patient?
=======
    var newPatient : PatientInformation?
    
    
    
    //Getting managedContext to use coredata
    var managedContext : NSObject{
        get{
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            return appDelegate!.persistentContainer.viewContext
        }
    }
>>>>>>> parent of 42da85d... Clean Up Repository
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
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
=======
//        let patient1 = Patient(name: "Alice", age: 56, gender: "Female", height: 162, weight: 65, admittedDate: "2/12/2017, 12:34 PM", icuWard: "North Wing")
//        let patient2 = Patient(name: "Bob", age: 32, gender: "Male", height: 150, weight: 43, admittedDate: "2/12/2017, 12:34 PM", icuWard: "North Wing")
//        let patient3 = Patient(name: "Cherry", age: 43, gender: "Female", height: 140, weight: 60, admittedDate: "2/12/2017, 12:34 PM", icuWard: "North Wing")
//        patients.append(patient1)
//        patients.append(patient2)
//        patients.append(patient3)
//        
        //Update patients array
//        if (newPatient != nil){
//            self.patients += [newPatient!]
//        }
        
       
        self.fetchData()
>>>>>>> parent of 42da85d... Clean Up Repository
        
        // Add search bar
        self.searchController = UISearchController(searchResultsController : self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //Show the list of patients when typing in the search bar
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        //Update the list
        self.searchController.searchResultsUpdater = self
    }
    
<<<<<<< HEAD
    func updateSearchResults(for searchController: UISearchController) {
        
        //Filter through the Patients
        self.filteredPatients = self.patients.filter{(patient : Patient) -> Bool in
            if patient.name.contains(self.searchController.searchBar.text!){
=======
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
>>>>>>> parent of 42da85d... Clean Up Repository
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
    
<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PInfo") as? PatientInfo {
            vc.selectedPatient = patients[indexPath.row]
=======
    // Click on the cell list --> carry index row and go to detail
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PInfo") as? PatientInfo {
            vc.selectedPatient = patients[indexPath.row]
            //self.performSegueWithIdentifier("SegueAdd", sender: indexPath.row)
>>>>>>> parent of 42da85d... Clean Up Repository
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        if let newPatientVC : PatientInfo = nav.viewControllers[0] as? PatientInfo {
            newPatientVC.updateClosure = {[weak self] patient in
<<<<<<< HEAD
                self?.patients.append(patient)
=======
                self?.fetchData()
>>>>>>> parent of 42da85d... Clean Up Repository
                self?.tableView.reloadData()
            }
        }
    }
    
<<<<<<< HEAD
    override func didReceiveMemoryWarning() {
=======
    
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
>>>>>>> parent of 42da85d... Clean Up Repository
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

<<<<<<< HEAD
=======

>>>>>>> parent of 42da85d... Clean Up Repository
