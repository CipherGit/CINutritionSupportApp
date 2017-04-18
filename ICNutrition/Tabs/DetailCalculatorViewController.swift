//
//  DetailCalculatorViewController.swift
//  ICNutrition
//
//  Created by LwinLwin Oo on 17/4/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DetailCalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectedFormula: UILabel!
    var picker_array : [String]!
    @IBOutlet weak var formulaPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker_array = ["formula 1","formula 2","formula 3"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return picker_array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return picker_array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedFormula.text = picker_array[row]
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
