//
//  ViewController.swift
//  PlannerTab
//
//  Created by Nicholas Zana on 9/21/17.
//  Copyright © 2017 Nicholas Zana. All rights reserved.
//

import UIKit
let C1Name = "Economics"

let C2Name = "Organic Chemistry"

let C3Name = "Fiction Workshop"

let C4Name = "Latin"

let C5Name = "Discrete Structures"

let C6Name = "Painting"

var doNotDelete: Bool = true

class PlannerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    var clickedCell:Int = 0
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.reloadData()
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        var namesArray = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        clickedCell = namesArray.count
        namesArray.append("")
        UserDefaults.standard.set(namesArray, forKey: "AssignmentNamesArray")
        var dueDateArray = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        dueDateArray.append(Date())
        UserDefaults.standard.set(dueDateArray, forKey: "AssignmentDueDateArray")
        print(UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!)
        var classArray = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        classArray.append(0)
        UserDefaults.standard.set(classArray, forKey: "AssignmentClassArray")
        var notesArray = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        notesArray.append("Notes")
        UserDefaults.standard.set(notesArray, forKey: "AssignmentNotesArray")
        UserDefaults.standard.synchronize()
        doNotDelete = false
    }
    
    //Tells how many cells need to be in the table view
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.array(forKey: "AssignmentNamesArray")!.count
    }
    //Adds ability to delete cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            var namesArray = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
            namesArray.remove(at: indexPath.row)
            UserDefaults.standard.set(namesArray, forKey: "AssignmentNamesArray")
            var dueDateArray = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
            dueDateArray.remove(at: indexPath.row)
            UserDefaults.standard.set(dueDateArray, forKey: "AssignmentDueDateArray")
            var classArray = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
            classArray.remove(at: indexPath.row)
            UserDefaults.standard.set(classArray, forKey: "AssignmentClassArray")
            var notesArray = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
            notesArray.remove(at: indexPath.row)
            UserDefaults.standard.set(namesArray, forKey: "AssignmentNotesArray")
            UserDefaults.standard.synchronize()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    //Creates Cells
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creates a cell as defined by prototype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AssignmentTableViewCellViewController
        //sets cell
        //Names
        let namesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        cell.assignmentNameLabel.text = namesArray[indexPath.row] as? String
        //Due Date
        func inputDateWeekdayAsString(Date:Date) -> String {
            let inputDate = Date
            
            let inputWeekday:Int = Calendar.current.component(.weekday, from: inputDate)
            
            let weekdayArray:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            if inputWeekday == nil {
                return "Error!"
            } else {
                return weekdayArray[inputWeekday - 1]
            }
        }
        let dueDateArray:Array = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        let inputDate:Date = dueDateArray[indexPath.row] as! Date
        let inputDateForDisplay: String = dateformatter.string(from: inputDate)
        let inputWeekdayAsStringVar = inputDateWeekdayAsString(Date: inputDate)
        let inputYear = Calendar.current.component(.year, from: inputDate)
        let inputMonth = Calendar.current.component(.month, from: inputDate)
        let inputDay = Calendar.current.component(.day, from: inputDate)
        let todayYear = Calendar.current.component(.year, from: Date())
        let todayMonth = Calendar.current.component(.month, from: Date())
        let todayDay = Calendar.current.component(.day, from: Date())
        var dueDateOutputString = "\(dueDateArray[indexPath.row])"
        
        if inputYear != todayYear {
            dueDateOutputString = "\(inputWeekdayAsStringVar), \(inputDateForDisplay)"
        } else if inputMonth != todayMonth {
            dueDateOutputString = "\(inputWeekdayAsStringVar), \(inputDateForDisplay)"
        } else if (inputDay - todayDay < 7) && (inputDay - todayDay > 0) {
            if inputDay - todayDay == 1 {
                dueDateOutputString = "Tommorow"
            } else {
                dueDateOutputString = "Next \(inputWeekdayAsStringVar)"
            }
        } else if (inputDay - todayDay > -7) && (inputDay - todayDay < 0) {
            if inputDay - todayDay == -1 {
                dueDateOutputString = "Yesterday"
            } else {
                dueDateOutputString = "Last \(inputWeekdayAsStringVar)"
            }
        } else if inputDay == todayDay {
            dueDateOutputString = "Today"
        } else {
            dueDateOutputString = "\(inputWeekdayAsStringVar), \(inputDateForDisplay)"
        }
        
        
        cell.assignmentDueDateLabel.text = dueDateOutputString
        //Class
        let assignmentClassArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        let array = [C1Name, C2Name, C3Name, C4Name, C5Name, C6Name]
        let int:Int = assignmentClassArray[indexPath.row] as! Int
        cell.assignmentClassLabel.text = array[int]
        
        return (cell)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75;//Sets height of each Assignment Cell
    }
    
    //Allows dragging around cell order
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Tells app how to reorder arrays when table view is changed
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Names
        var namesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        let namesItem = namesArray[sourceIndexPath.row]
        namesArray.remove(at: sourceIndexPath.row)
        namesArray.insert(namesItem, at: destinationIndexPath.row)
        UserDefaults.standard.set(namesArray, forKey: "AssignmentNamesArray")
        //DueDates
        var dueDateArray:Array = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        let dueDateItem = dueDateArray[sourceIndexPath.row]
        dueDateArray.remove(at: sourceIndexPath.row)
        dueDateArray.insert(dueDateItem, at: destinationIndexPath.row)
        UserDefaults.standard.set(dueDateArray, forKey: "AssignmentDueDateArray")
        //Class
        var classArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        let classItem = classArray[sourceIndexPath.row]
        classArray.remove(at: sourceIndexPath.row)
        classArray.insert(classItem, at: destinationIndexPath.row)
        UserDefaults.standard.set(classArray, forKey: "AssignmentClassArray")
        //Notes
        var notesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        let notesItem = namesArray[sourceIndexPath.row]
        notesArray.remove(at: sourceIndexPath.row)
        notesArray.insert(notesItem, at: destinationIndexPath.row)
        UserDefaults.standard.set(notesArray, forKey: "AssignmentNotesArray")
        //Synchronizes UserDefaults
        UserDefaults.standard.synchronize()
    }
    @IBAction func didPressEditButton(_ sender: Any) {
        //Enables dragging around items
        tableView.isEditing = !tableView.isEditing
        
        if tableView.isEditing == true {
            editButton.setTitle("Done", for: .normal)
        } else {
            editButton.setTitle("Edit", for: .normal)
        }
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickedCell = indexPath.row
        performSegue(withIdentifier: "toNewAssignmentSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newAssignmentViewController = segue.destination as! NewAssignmentViewController
        newAssignmentViewController.clickedCellPath = clickedCell
        newAssignmentViewController.doNotDelete = doNotDelete
    }
    
    func reloadTableData() {
        tableView.reloadData()
    }
}


