//
//  SecondViewController.swift
//  CI1
//
//  Created by lijinjin on 21/2/17.
//  Copyright © 2017 lijinjin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var list = ["1", "2", "3"]
    
    @IBOutlet weak var diseaseNameText: UITextField!
    
    @IBOutlet weak var severityLevelText: UITextField!
    
    @IBOutlet weak var diseasePhaseText: UITextField!
    
    @IBAction func addDiseaseBtn(_ sender: UIButton) {
    }
    
    
    
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return cell;
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        diseaseNameText.resignFirstResponder()
        severityLevelText.resignFirstResponder()
        diseasePhaseText.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

