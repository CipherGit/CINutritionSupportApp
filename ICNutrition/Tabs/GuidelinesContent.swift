//
//  GuidelinesContent.swift
//  ICNutrition
//
//  Created by Justin Peña on 16/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class GuidelinesContent: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var guideLineSource : GLSource?
    var guidelines = [Guideline]()
    var sections = [String]()
    var sectionItems = Array<Array<Guideline>>()
    @IBOutlet weak var glContentTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Change Title
        self.title = guideLineSource?.glName
        
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
        
        //Set the Delagate and Data Source for the Table
        glContentTable.delegate = self
        glContentTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glContentCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = sectionItems[indexPath.section][indexPath.row].shortDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Hello")
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
