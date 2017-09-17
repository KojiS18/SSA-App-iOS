//
//  ChangeOneRegularTableViewCell.swift
//  Alpha
//
//  Created by pro admin on 9/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ChangeOneRegularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayPeriod: UILabel!
    
    @IBOutlet weak var nameOfPeriod: UITextField!
    
    public var cellDelegate: ChangeOneProtocol!
    var row: Int = -1
    
    
    
    @IBAction func endEdit(_ sender: UITextField) {
        if let a = sender.text {
            cellDelegate.didChangeName(row: row, text: a)
        } else {
            cellDelegate.didChangeName(row: row, text: "")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
