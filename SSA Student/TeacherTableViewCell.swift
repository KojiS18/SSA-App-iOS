//
//  TeacherTableViewCell.swift
//  SSA Student
//
//  Created by pro admin on 9/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIApplication.shared.openURL(URL(string: "https://www.shadysideacademy.org/students/ms-ss-student-portal")!)
        }
        
        // Configure the view for the selected state
    }

}
