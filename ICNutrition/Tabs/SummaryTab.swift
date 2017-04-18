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

class SummaryTab: UIViewController {
    
    var selectedPatient : Patient?
    var diseases = [Disease]()
    var guidelines = [Guideline]()
    var tokenizedWords = [String]()
    
    @IBOutlet weak var Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieve patient and diseases
        selectedPatient = (tabBarController as! IcuTabController).selectedPatient
        print(selectedPatient?.name)
        diseases = selectedPatient?.patientToMany_Disease?.allObjects as! [Disease]
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
