//
//  DiseaseTableViewCell.swift
//  ICNutrition
//
//  Created by lijinjin on 14/3/17.
//  Copyright © 2017 Cipher. All rights reserved.
//

import UIKit

class DiseaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var diseaseLabel: UILabel!
    
    @IBOutlet weak var severityLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
