//
//  FriendsTableViewController.swift
//  SSA Student
//
//  Created by pro admin on 9/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var namesArray: [String] = []
    var allFriendsFrees: [[Bool]] = []
    let dic = [0: 0, 1: 8, 2: 16, 3: 24, 4: 32, 5: 40, 6: 48, 7: 56]
    var todayCycle: Int? = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults:UserDefaults = UserDefaults.standard
        todayCycle = defaults.integer(forKey: "today")
        print("friends thinks today is day \(todayCycle)")
        self.title = "Friends"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.editButtonItem.tintColor = UIColor.white
        
     self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
        let defaults:UserDefaults = UserDefaults.standard
        
        if let n = defaults.array(forKey: "namesArray")  {
            let nn = n as! [String]
            namesArray = nn
        }
        if let n2 = defaults.array(forKey: "all") {
            let nn2 = n2 as! [[Bool]]
            allFriendsFrees = nn2
        }
        
        
        self.tableView.reloadData()
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
        print("rows \(namesArray.count)")
        return namesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendfree", for: indexPath)
        print("generating row \(indexPath.row)")
        cell.textLabel?.text = namesArray[indexPath.row]
        cell.detailTextLabel?.text = generateFrees(nthFriend: indexPath.row)
        cell.showsReorderControl = true
        
        
        
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults:UserDefaults = UserDefaults.standard
        var friendNames = defaults.array(forKey: "namesArray") as! [String]
        let t = friendNames[indexPath.row]
        let alertController = UIAlertController(title: "Change Name", message: "Change your friend's name to", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: ({ (textField) -> Void in
            textField.text = t}))
        let okButton = UIAlertAction(title: "Done", style: .default, handler: {(action) -> Void in
            let textField = alertController.textFields![0] as UITextField
            if textField.text != t && textField.text != ""{
                friendNames[indexPath.row] = textField.text!
                self.namesArray = friendNames
                defaults.set(friendNames, forKey: "namesArray")
                self.tableView.reloadData()
                
            }
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okButton)
        alertController.addAction(cancel)
        self.present(alertController,animated: true, completion: nil)
        
    }
    
    func generateFrees(nthFriend: Int)->String {
        var res = ""
        if let tc = todayCycle, let startNum = dic[tc-1] {
            if tc == 0 {
                return ""
            }
            res = "Day \(tc) Frees: "
            var counter = 0
            var first = true
            
            print(allFriendsFrees)
            for n in startNum...(startNum + 7) {
                print(counter)
                print(n)
                
                if allFriendsFrees[nthFriend][n]==true {
                    if first {
                        res.append("P")
                    }
                    switch counter {
                    case 0: res.append("1,")
                    case 1: res.append("2,")
                    case 2: res.append("3,")
                    case 3: res.append("4A,")
                    case 4: res.append("4B,")
                    case 5: res.append("4C,")
                    case 6: res.append("5,")
                    case 7: res.append("6,")
                    default: res.append("error")
                    }
                    first = false
                    
                }
                
                counter = counter + 1
                
            }
            let index = res.index(res.endIndex, offsetBy: -1)
            if res[index] == "," {
                res.remove(at: index)
            }
            if res.contains("4A,4B,4C") {
                res = res.replacingOccurrences(of: "4A,4B,4C", with: "4ABC")
                
            } else if res.contains("4A,4B") {
                res = res.replacingOccurrences(of: "4A,4B", with: "4AB")
            } else if res.contains("4B,4C") {
                res = res.replacingOccurrences(of: "4B,4C", with: "4BC")
            } else if res.contains("4A,4C") {
                res = res.replacingOccurrences(of: "4A,4C", with: "4AC")
            }
            return res
            
            
        }
        return ""
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            namesArray.remove(at: indexPath.row)
            allFriendsFrees.remove(at: indexPath.row)
            let defaults:UserDefaults = UserDefaults.standard
            defaults.set(namesArray, forKey: "namesArray")
            defaults.set(allFriendsFrees, forKey: "all")
            print("changed names to \(namesArray)")
            print("changed frees to \(allFriendsFrees)")
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let defaults:UserDefaults = UserDefaults.standard
        let nameBeingMoved = namesArray.remove(at: fromIndexPath.row)
        namesArray.insert(nameBeingMoved, at: to.row)
        let freesBeingMoved = allFriendsFrees.remove(at: fromIndexPath.row)
        allFriendsFrees.insert(freesBeingMoved, at: to.row)
        defaults.set(namesArray, forKey: "namesArray")
        defaults.set(allFriendsFrees, forKey: "all")
        
    }
    

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
