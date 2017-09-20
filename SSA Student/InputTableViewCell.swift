//
//  InputTableViewCell.swift
//  Alpha
//
//  Created by pro admin on 8/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell {

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
    
    /*
    @IBAction func changeFree(_ sender: UISwitch) {
        if sender.isOn {
            cellDelegate?.didSelectFree(row: row, free: true)
            ABorBC.selectedSegmentIndex = 0
            NorSci.selectedSegmentIndex = 0
            
            nameOfPeriod.text = "Free"
            nameOfPeriod.alpha = 0.3
            nameOfPeriod.isEnabled = false
            
            ABorBC.isEnabled = false
            NorSci.isEnabled = false
        } else {
            cellDelegate?.didSelectFree(row: row, free: false)
            nameOfPeriod.isEnabled = true
            nameOfPeriod.text = ""
            nameOfPeriod.alpha = 1.0
            ABorBC.isEnabled = true
            NorSci.isEnabled = true
        }
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
