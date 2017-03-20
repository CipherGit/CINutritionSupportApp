//
//  AddScreenViewController.swift
//  TestingTablewithSearchBar
//
//  Created by LwinLwin Oo on 22/2/17.
//  Copyright © 2017 LwinLwin Oo. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController {

    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    var updateClosure:((_ name : String)->Void)? //just for test purpose. Normally you need to save all the new values to database (coredata), then go back to first screena and reload(refresh) the table.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        //print (textFieldName.text!)
        /* below code means, you created new TestingTableViewController again.
         
         
        let myVC = storyboard?.instantiateViewController(withIdentifier: "TestingTableViewController") as! TestingTableViewController
        myVC.stringPassed = textFieldName.text!
        navigationController?.pushViewController(myVC, animated: true)
        */
        
        self.updateClosure!(textFieldName.text!)
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnCancel(_ sender : Any){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        let navVC = segue.destination as? UINavigationController
        
        let tableVC = navVC?.viewControllers.first as! TestingTableViewController
        
        tableVC.stringPassed = textFieldName.text!
 */
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