//
//  AssignmentTableViewCellViewController.swift
//  PlannerTab
//
//  Created by Nicholas Zana on 9/21/17.
//  Copyright © 2017 Nicholas Zana. All rights reserved.
//

import UIKit

class AssignmentTableViewCellViewController: UITableViewCell {

    @IBOutlet weak var assignmentNameLabel: UILabel!
    @IBOutlet weak var assignmentDueDateLabel: UILabel!
    @IBOutlet weak var assignmentClassLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
