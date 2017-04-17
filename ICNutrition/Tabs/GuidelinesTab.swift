//
//  GuidelinesTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit
import CoreData

class GuidelinesTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var targetPatient : Patient?
    var guidelineSources = Array<GLSource>();
    @IBOutlet weak var glsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check Active Patient
        //NSLog("Current Patient:" + (targetPatient?.name)!)
        
        //Check Associated Diseases
        //Just wanted to see if this worked and it does
        //let diseaseArray = targetPatient?.patientToMany_Disease?.allObjects as! [Disease]
        //for disease in diseaseArray {
        //    NSLog("Associated Disease: " + disease.diseaseName!)
        //}
        
        //Fetch GLSources
        fetchGLSources()
        for glSource in guidelineSources {
            NSLog(glSource.glName!)
        }
        
        //Set the Delagate and Data Source for the Table
        glsTable.delegate = self
        glsTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func fetchGLSources(){
        let context = self.context
        let request : NSFetchRequest<GLSource> = GLSource.fetchRequest()
        do{
            guidelineSources = try (context!.fetch(request)) as [GLSource]
            NSLog("Loaded GLSources")
        }catch{
            let fetchError = error as NSError
            NSLog(fetchError.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guidelineSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glSourceCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = guidelineSources[indexPath.row].glName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog(guidelineSources[indexPath.row].glName!)
        performSegue(withIdentifier: "glContentsSegue", sender: guidelineSources[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "glContentsSegue"){
            let guidelinesContent = segue.destination as! GuidelinesContent
            guidelinesContent.guideLineSource = sender as? GLSource
        }
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
