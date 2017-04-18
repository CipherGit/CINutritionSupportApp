//
//  GuidelinesContent.swift
//  ICNutrition
//
//  Created by Justin Peña on 16/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit
import Foundation

class GuidelinesContent: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var guideLineSource : GLSource?
    var guidelines = [Guideline]()
    var filteredGuidelines = [Guideline]()
    var sections = [String]()
    var searchActive : Bool = false
    var sectionItems = Array<Array<Guideline>>()
    @IBOutlet weak var glContentTable: UITableView!
    @IBOutlet weak var glContentLabel: UILabel!
    @IBOutlet weak var glcSearch: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Change Title
        glContentLabel.text = guideLineSource?.glName
        
        //Check guidelines in GLSource
        NSLog("Number of Guidelines: " + String(describing: guideLineSource?.glsToMany_gl?.count))
        
        //Get the guidelines from GLSource
        guidelines = guideLineSource?.glsToMany_gl?.allObjects as! [Guideline]
        
        //Sort guidlines
        guidelines.sort { $0.gID < $1.gID }
        
        //Fill the section array
        var prevSection = ""
        for guideline in guidelines {
            let section = guideline.category
            if(section != prevSection){
                sections.append(section!)
            }
            prevSection = section!
        }
        
        //Fill the items array
        for section in sections {
            var gArr = [Guideline]()
            for guideline in guidelines {
                if(section == guideline.category) {
                    gArr.append(guideline)
                }
            }
            sectionItems.append(gArr)
        }
        
        //Set the Delagate and Data Source for the tables and search bar
        glContentTable.delegate = self
        glContentTable.dataSource = self
        glcSearch.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !searchActive {
            return sections.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !searchActive {
            return sections[section]
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchActive {
            return sectionItems[section].count
        } else {
            return filteredGuidelines.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glContentCell", for: indexPath) as UITableViewCell
        
        if !searchActive {
            cell.textLabel?.text = sectionItems[indexPath.section][indexPath.row].shortDesc
        } else {
            cell.textLabel?.text = filteredGuidelines[indexPath.row].shortDesc
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Hello")
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
        filteredGuidelines = guidelines.filter({ ($0.shortDesc?.contains(searchText))!})
        if(filteredGuidelines.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        glContentTable.reloadData()
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
