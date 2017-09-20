//
//  ChangeAllTableViewCell.swift
//  Alpha
//
//  Created by pro admin on 8/24/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ChangeAllTableViewCell: UITableViewCell {
    public var cellDelegate: inputProtocol!
    var row: Int = -1
    @IBOutlet weak var dayNNum: UILabel!
    
    @IBOutlet weak var nameOfPeriod: UITextField!
    
    // @IBOutlet weak var isFree: UISwitch!
    
    @IBOutlet weak var ABorBC: UISegmentedControl!
    
    @IBOutlet weak var NorSci: UISegmentedControl!
    
    
    @IBAction func endEdit(_ sender: UITextField) {
        if let a = sender.text {
            cellDelegate.didChangeName(row: row, text: a)
        } else {
            cellDelegate.didChangeName(row: row, text: "")
        }
    }
    
    @IBAction func changeAB(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            cellDelegate.didSelectAB(row: row, ab: true)
        } else {
            cellDelegate.didSelectAB(row: row, ab: false)
        }
        
    }
    
    @IBAction func changeSci(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            cellDelegate.didSelectRegular(row: row, nor: true)
        } else {
            cellDelegate.didSelectRegular(row: row, nor: false)
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
