//
//  InputTableViewController.swift
//  Alpha
//
//  Created by pro admin on 8/17/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class InputTableViewController: UITableViewController, inputProtocol{
    
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputcell", for: indexPath) as! InputTableViewCell
        
        cell.cellDelegate = self
        
        cell.selectionStyle = .none
        
        cell.dayNNum.text = String(indexPath.row + 1)
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
