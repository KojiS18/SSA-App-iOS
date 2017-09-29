//
//  ChangeOneTableViewController.swift
//  Alpha
//
//  Created by pro admin on 9/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ChangeOneTableViewController: UITableViewController, ChangeOneProtocol {
    var whole: [[String]] = []
    var dayN: Int = 0
    var names: [String] = []
    var isAB: Bool = false
    func didSelectAB(ab: Bool) {
        isAB = ab
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
        
        //self.view.sendSubview(toBack: (self.tableView.footerView(forSection: 0))!.contentView)
        
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
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "regular", for: indexPath) as! ChangeOneRegularTableViewCell
            //cell.isUserInteractionEnabled = true
            //cell.bringSubview(toFront: cell.contentView)
            cell.cellDelegate = self
            cell.dayPeriod.text = "Period \(indexPath.row+1) Day \(dayN)"
            cell.nameOfPeriod.text = names[indexPath.row]
            cell.row = indexPath.row
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "p4", for: indexPath) as! ChangeOneP4TableViewCell
            //cell.isUserInteractionEnabled = true
            cell.bringSubview(toFront: cell.contentView)
            cell.cellDelegate = self
            cell.dayPeriod.text = "Period \(indexPath.row+1) Day \(dayN)"
            cell.nameOfPeriod.text = names[3]
            cell.row = indexPath.row
            if isAB {
                cell.lunch.selectedSegmentIndex = 0
            } else {
                cell.lunch.selectedSegmentIndex = 1

            }
            
            return cell
        }
        

        // Configure the cell...

        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 3 {
            let h: CGFloat = 80
            return h
        } else {
            let h: CGFloat = 119
            return h
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
