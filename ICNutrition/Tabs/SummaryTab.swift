//
//  SummaryTab.swift
//  ICNutrition
//
//  Created by lijinjin on 21/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class SummaryTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedPatient : Patient?
    var patientCalc : PatientCalculation?
    var diseases = [Disease]()
    var guidelines = [Guideline]()
    var recommended = Set<Guideline>()
    var recArr = [Guideline]()
    var tokenizedWords = [String]()
    
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var tdeeLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var recTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieve data        
        selectedPatient = (tabBarController as! IcuTabController).selectedPatient
        diseases = selectedPatient?.patientToMany_Disease?.allObjects as! [Disease]
        let ptcAll = selectedPatient?.patientToMany_Ptc?.allObjects as! [PatientCalculation]
        

        for calc in ptcAll {
            if(calc.ptcToCalc?.calcName=="Caloric Requirements"){
                patientCalc = calc
                break
            }
        }
         
        
        if(patientCalc == nil){
            let alert = UIAlertController(title: "Greetings!", message: "Please click on the calculator tab to make nutrition calculations", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let outputString = patientCalc?.output?.components(separatedBy: ",")
            for pair in outputString! {
                let splitResult = pair.components(separatedBy: ":")
                switch splitResult[0] {
                case "BMI":
                    bmiLabel.text = "BMI: " + splitResult[1]
                    bmiLabel.sizeToFit()
                case "TDEE":
                    tdeeLabel.text = "TDEE: " + splitResult[1] + " kcal/d"
                    tdeeLabel.sizeToFit()
                case "Carbs":
                    carbsLabel.text = "Carbs: " + splitResult[1] + " g/d"
                    carbsLabel.sizeToFit()
                case "Proteins":
                    proteinLabel.text = "Proteins: " + splitResult[1] + " g/d"
                    proteinLabel.sizeToFit()
                case "Fats":
                    fatLabel.text = "Fats: " + splitResult[1] + " g/d"
                    fatLabel.sizeToFit()
                default:
                    NSLog("No label for key: %@", splitResult[1])
                }
            }
        }


        //Combine disease information and tokenize
        for disease in diseases {
            let diseaseTokens = disease.diseaseName?.components(separatedBy: " ")
            let notesTokens = disease.diseaseNotes?.components(separatedBy: " ")
            let combinedTokens = diseaseTokens! + notesTokens!
            let tokenSet = Set(combinedTokens)
            for token in tokenSet {
                tokenizedWords.append(token)
            }
        }
        
        //Remove duplicates in tokenizedWords
        let allTokenSet = Set(tokenizedWords)
        
        //Define stopwords
        let stopWords = ["a","about","above","after","again","against","all","am","an","and","any","are","aren't","as","at","be","because","been","before","being","below","between","both","but","by","can't","cannot","could","couldn't","did","didn't","do","does","doesn't","doing","don't","down","during","each","few","for","from","further","had","hadn't","has","hasn't","have","haven't","having","he","he","'d","he","'ll","he","'s","her","here","here's","hers","herself","him","himself","his","how","how's","i","'d","'ll","'m","'ve","if","in","into","is","isn't","it","it's","its","itself","let's","me","more","most","mustn't","my","myself","no","nor","not","of","off","on","once","only","or","other","ought","our","ours","ourselves","out","over","own","same","shan't","she","she'd","she'll","she's","should","shouldn't","so","some","such","than","that","that's","the","their","theirs","them","themselves","then","there","there's","these","they","they'd","they'll","they're","they've","this","those","through","to","too","under","until","up","very","was","wasn't","we","we'd","we'll","we're","we've","were","weren't","what","what's","when","when's","where","where's","which","while","who","who's","whom","why","why's","with","won't","would","wouldn't","you","you'd","you'll","you're","you've","your","yours","yourself","yourselves"]
        
        //Filter out stopwords
        for word in stopWords {
            tokenizedWords = allTokenSet.filter(){$0 != word}
        }
        
        //Retrieve Guidelines
        retrieveGuidelines()
        
        //Filter out Guidelines
        for word in tokenizedWords {
            let gfilter = guidelines.filter({ ($0.glToOne_Index?.keywords?.contains(word))! || ($0.shortDesc?.contains(word))!})
            for gline in gfilter {
                recommended.insert(gline)
            }
        }
        
        //Convert to Array for easier access
        recArr = Array(recommended)
        
        print(recArr.count)
        
        recTable.delegate = self
        recTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath)
        cell.textLabel?.text = recArr[indexPath.row].shortDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "recGlSegue", sender: recArr[indexPath.row])
    }
    
    func retrieveGuidelines(){
        let context = self.context
        let request : NSFetchRequest<Guideline> = Guideline.fetchRequest()
        do{
            guidelines = try (context!.fetch(request)) as [Guideline]
        }catch{
            let fetchError = error as NSError
            NSLog(fetchError.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "recGlSegue"){
            let recDetail = segue.destination as! RecommendationDetail
            recDetail.guideline = sender as! Guideline
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
