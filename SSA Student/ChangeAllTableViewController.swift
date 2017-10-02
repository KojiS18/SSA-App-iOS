//
//  InputTableViewController.swift
//  Alpha
//
//  Created by pro admin on 8/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ChangeAllTableViewController: UITableViewController, inputProtocol {
    
    var names: [String] = [String](repeating: "", count: 8)
    var isNormal: [Bool] = [Bool](repeating: true, count: 8)
    var isAB: [Bool] = [Bool](repeating: true, count: 8)
    //var isFree: [Bool] = [Bool](repeating: false, count: 8)
    
    
    func didSelectRegular(row: Int, nor: Bool) {
        if nor{
            isNormal[row] = true
        } else {
            isNormal[row] = false
        }
        
    }
    func didSelectAB(row: Int, ab: Bool) {
        if ab{
            isAB[row] = true
        } else {
            isAB[row] = false
        }
        
    }
    func didChangeName(row:Int, text: String) {
        names[row] = text
        if text.contains("free") && text.characters.count < 7 {
            names[row] = "Free"
        }
        if text.contains("Free") && text.characters.count < 7 {
            names[row] = "Free"
        }
        var arrayForSave:[Int] = []
        var i:Int = 0
        let pulledArray = UserDefaults.standard.array(forKey: "AssignmentNamesArray")
        while i < pulledArray!.count {
            arrayForSave.append(0)
            i = i + 1
        }
        
        UserDefaults.standard.set(arrayForSave, forKey: "AssignmentClassArray")
        UserDefaults.standard.synchronize()
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    override func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return "Leave blank if free"
    }
    override func tableView(_ tableView: UITableView,
                            titleForFooterInSection section: Int) -> String? {
        return "Leave blank if free"
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let a: CGFloat = 212.0
        return a
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allcell", for: indexPath) as! ChangeAllTableViewCell
        //cell.isUserInteractionEnabled = true
        cell.cellDelegate = self
        
        //cell.sendSubview(toBack: cell.contentView)
        //cell.bringSubview(toFront: cell.contentView)
        cell.selectionStyle = .none
        
        cell.dayNNum.text = "Day \(indexPath.row + 1) Period 4 "
        //cell.isFree.setOn(false,animated: false)
        cell.row = indexPath.row
        cell.nameOfPeriod.text = names[indexPath.row]
        if isAB[indexPath.row] {
            cell.ABorBC.selectedSegmentIndex = 0
        } else {
            cell.ABorBC.selectedSegmentIndex = 1
        }
        if isNormal[indexPath.row] {
            cell.NorSci.selectedSegmentIndex = 0
        } else {
            cell.NorSci.selectedSegmentIndex = 1
        }
        
        
        return cell
    }
    
    
    
    
}
