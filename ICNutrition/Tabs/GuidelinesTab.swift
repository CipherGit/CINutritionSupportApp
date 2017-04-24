//
//  GuidelinesTab.swift
//  ICNutrition
//
//  Created by lijinjin on 23/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit
import CoreData

class GuidelinesTab: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var selectedPatient : Patient?
    var guidelineSources = [GLSource]()
    var glsFiltered = [GLSource]()
    var searchActive : Bool = false
    @IBOutlet weak var glsTable: UITableView!
    @IBOutlet weak var glsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fetch GLSources
        fetchGLSources()
        for glSource in guidelineSources {
            NSLog(glSource.glName!)
        }
        
        //Set the Delagate and Data Source for the table and search bar
        glsTable.delegate = self
        glsTable.dataSource = self
        glsSearchBar.delegate = self
        
    }
    
    func fetchGLSources(){
        let context = self.context
        let request : NSFetchRequest<GLSource> = GLSource.fetchRequest()
        do{
            guidelineSources = try (context!.fetch(request)) as [GLSource]
        }catch{
            let fetchError = error as NSError
            NSLog(fetchError.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchActive {
            return guidelineSources.count
        } else {
            return glsFiltered.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glSourceCell", for: indexPath) as UITableViewCell
        if !searchActive {
            cell.textLabel?.text = guidelineSources[indexPath.row].glName
        } else {
            cell.textLabel?.text = glsFiltered[indexPath.row].glName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data : GLSource
        if !searchActive {
            data = guidelineSources[indexPath.row]
        } else {
            data = glsFiltered[indexPath.row]
        }
        performSegue(withIdentifier: "glContentsSegue", sender: data)
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
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        glsFiltered = guidelineSources.filter({($0.glName?.contains(searchText))!})
        if glsFiltered.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        glsTable.reloadData()
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
