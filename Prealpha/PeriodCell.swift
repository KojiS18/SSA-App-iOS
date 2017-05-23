//
//  PeriodCell.swift
//  Prealpha
//
//  Created by Peter W on 5/11/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

class PeriodCell: UITableViewCell{
    
    
    
    @IBOutlet var periodtime: UILabel!
    @IBOutlet var wclass: UILabel!
    @IBOutlet var whichperiod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
