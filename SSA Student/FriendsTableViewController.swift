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
    var school: [[Int]]? = []
    let dic = [0: 0, 1: 8, 2: 16, 3: 24, 4: 32, 5: 40, 6: 48, 7: 56]
    var todayCycle: Int? = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        school = ReadSchoolDays()
        let defaults:UserDefaults = UserDefaults.standard
        todayCycle = defaults.integer(forKey: "today")
        print("friends thinks today is day \(todayCycle)")
        self.title = "Contacts"
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
        cell.detailTextLabel?.attributedText = generateFancyFrees(nthFriend: indexPath.row)
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
    func generateFancyFrees(nthFriend: Int)->NSAttributedString {
        var cycleDayWeNeedToGenerate = 0
        let lastOnPage = UserDefaults.standard.integer(forKey: "atPage")
        if lastOnPage==999 || lastOnPage==0 {
            //We don't know which page user was last on.
            //generate frees for today
            if let tc = todayCycle {
                cycleDayWeNeedToGenerate = tc
            } else {
                //return N/A
                cycleDayWeNeedToGenerate = 0
            }
        } else {
            //We do know which page user was last on.
            if school != nil && school!.count>lastOnPage && school![lastOnPage].count == 7 {
                let c = school![lastOnPage][5]
                cycleDayWeNeedToGenerate = c
                
            } else {
                //return N/A
                cycleDayWeNeedToGenerate = 0
            }
        }
        var s = ""
        switch cycleDayWeNeedToGenerate {
        case 1,2,3,4,5,6,7,8:
            var s = "Day \(cycleDayWeNeedToGenerate): 1 2 3 ABC 5 6 "
            var r = NSMutableAttributedString(
                string: s,
                attributes: [NSFontAttributeName:UIFont(
                    name: "HelveticaNeue",
                    size: 14.0)!])
            let start = (cycleDayWeNeedToGenerate-1) * 8
            
            
            for n in 0...7 {
                var toColor = ""
                if allFriendsFrees[nthFriend][start + n]==true {
                    switch n {
                    case 0: toColor = "1 "
                    case 1: toColor = "2 "
                    case 2: toColor = "3 "
                    case 3: toColor = "A"
                    case 4: toColor = "B"
                    case 5: toColor = "C"
                    case 6: toColor = "5 "
                    case 7: toColor = "6 "
                    default: break
                    }
                    let range = (s as NSString).range(of: toColor)
                    r.addAttribute(NSForegroundColorAttributeName, value: UIColor.green , range: range)
                } else {
                    switch n {
                    case 0: toColor = "1 "
                    case 1: toColor = "2 "
                    case 2: toColor = "3 "
                    case 3: toColor = "A"
                    case 4: toColor = "B"
                    case 5: toColor = "C"
                    case 6: toColor = "5 "
                    case 7: toColor = "6 "
                    default: break
                    }
                    let range = (s as NSString).range(of: toColor)
                    r.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray , range: range)
                }
            }
            return r
        
        default: break
            
        }
        s = "N/A"
        var r = NSMutableAttributedString(
            string: s,
            attributes: [NSFontAttributeName:UIFont(
                name: "HelveticaNeue",
                size: 14.0)!])
        return r
        
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
        func ReadSchoolDays()->[[Int]]?{
            let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
            
            let jsonFilePath = documentsDirectoryPath.appendingPathComponent("schoolDaysInfo.json")
            let fileManager = FileManager.default
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
                do {
                    
                    if let jdata = fileManager.contents(atPath: (jsonFilePath?.absoluteString)!) {
                        
                        let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                        if let object = json as? [[Int]] {
                            // json is a dictionary
                            //print(object)
                            //print("school days read")
                            return object
                        } else {
                            print("JSON is invalid")
                        }
                    } else {
                        
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                return nil
                
            }
            
            return nil
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
