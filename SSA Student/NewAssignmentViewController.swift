//
//  NewAssignmentViewController.swift
//  PlannerTab
//
//  Created by Nicholas Zana on 9/21/17.
//  Copyright © 2017 Nicholas Zana. All rights reserved.
//

import UIKit

class NewAssignmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {

 
    @IBOutlet weak var assignmentTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var classPicker: UIPickerView!
    var array:Array = UserDefaults.standard.array(forKey: "ClassNamesArray")!
    var selectedClassValue:Int = 0
    var clickedCellPath:Int = 0
    var recievedIndex:Int = 0
    var recievedPeriod:Int = 0
    var indexForSave:Int = 0
    var periodForSave: Int = 0
    
    var doNotDelete:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.assignmentTextField.delegate = self
        notesTextView.delegate = self
        UserDefaults.standard.synchronize()
        //Sets values of input objects to either be new things or saved values
        var namesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        var dueDateArray:Array = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        var classArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        var notesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        var duePeriodArray:Array = UserDefaults.standard.array(forKey: "DuePeriodArray")!
        selectedClassValue = classArray[clickedCellPath] as! Int
        notesTextView.text = notesArray[clickedCellPath] as! String
        assignmentTextField.text = namesArray[clickedCellPath] as! String
        let previousClass = classArray[clickedCellPath] as! Int
        classPicker.selectRow(previousClass, inComponent: 0, animated: false)
        
        recievedIndex = dueDateArray[clickedCellPath] as! Int
        recievedPeriod = duePeriodArray[clickedCellPath] as! Int
        indexForSave = recievedIndex
        periodForSave = recievedPeriod
        
        pickerView.selectRow(recievedIndex, inComponent: 0, animated: false)
        pickerView.selectRow(recievedPeriod, inComponent: 1, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressFinish(_ sender: Any) {
        print(clickedCellPath)
        var namesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        namesArray[clickedCellPath] = "\(assignmentTextField.text!)"
        UserDefaults.standard.set(namesArray, forKey: "AssignmentNamesArray")
        var dueDateArray:Array = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        dueDateArray[clickedCellPath] = indexForSave
        UserDefaults.standard.set(dueDateArray, forKey: "AssignmentDueDateArray")
        var classArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        classArray[clickedCellPath] = selectedClassValue
        UserDefaults.standard.set(classArray, forKey: "AssignmentClassArray")
        var notesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        notesArray[clickedCellPath] = notesTextView.text!
        UserDefaults.standard.set(notesArray, forKey: "AssignmentNotesArray")
        var duePeriodArray:Array = UserDefaults.standard.array(forKey: "DuePeriodArray")!
        duePeriodArray[clickedCellPath] = periodForSave
        UserDefaults.standard.set(duePeriodArray, forKey: "DuePeriodArray")
        UserDefaults.standard.synchronize()
        
        dismiss(animated: true, completion: nil)

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == classPicker {
            return 1
        } else {
            return 2
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == classPicker {
            return array.count
        } else {
            if component == 0 {
                return arrayOfSchoolYear.count
                } else {
                return 6
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == classPicker {
            var label: UILabel
            if let view = view as? UILabel { label = view }
            else { label = UILabel() }
            
            label.text = array[row] as! String
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            
            return label
        } else {
            if component == 0 {
                var label: UILabel
                if let view = view as? UILabel { label = view }
                else { label = UILabel() }
                
                let df = DateFormatter()
                df.dateStyle = .full
                label.text = df.string(from: getDateFromIndex(inputPath: row))
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 20)
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                
                return label
            } else {
                var label: UILabel
                if let view = view as? UILabel { label = view }
                else { label = UILabel() }
                
                label.text = "Period \(row + 1)"
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 20)
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
                
                return label
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == classPicker {
        selectedClassValue = row
        } else {
            if component == 0 {
                indexForSave = row
                print(indexForSave)
            } else {
                periodForSave = row
                print(periodForSave)
            }
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
 
    @IBAction func didPressCancel(_ sender: Any) {
        
        var namesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        namesArray.remove(at: clickedCellPath)
        UserDefaults.standard.set(namesArray, forKey: "AssignmentNamesArray")
        var dueDateArray:Array = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        dueDateArray.remove(at: clickedCellPath)
        UserDefaults.standard.set(dueDateArray, forKey: "AssignmentDueDateArray")
        var classArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        classArray.remove(at: clickedCellPath)
        UserDefaults.standard.set(classArray, forKey: "AssignmentClassArray")
        var notesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        notesArray.remove(at: clickedCellPath)
        UserDefaults.standard.set(notesArray, forKey: "AssignmentNotesArray")
        var duePeriodArray = UserDefaults.standard.array(forKey: "DuePeriodArray")!
        duePeriodArray.remove(at: clickedCellPath)
        UserDefaults.standard.set(duePeriodArray, forKey: "DuePeriodArray")
        UserDefaults.standard.synchronize()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        array = UserDefaults.standard.array(forKey: "ClassNamesArray")! as! [String]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func getDateFromIndex(inputPath:Int) -> Date {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let inputtedDateArray = arrayOfSchoolYear[inputPath]
        let inputtedDay = inputtedDateArray[2]
        let inputtedMonth = inputtedDateArray[1]
        let inputtedYear = inputtedDateArray[3]
        let inputtedDate:Date = df.date(from: "\(inputtedYear)-\(inputtedMonth)-\(inputtedDay)")!
        return inputtedDate
    }
    
    //Adapted from Peter's method "getTodayIndex" in RootViewController
    func getIndexFromDate(inputDate:Date)->Int{
        let date = inputDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var year = components.year!
        var month = components.month!
        var day = components.day!
        let schoolDays = arrayOfSchoolYear
        var index = schoolDays.index(where:{$0[3]==year&&$0[1]==month&&$0[2]==day})
        let maxLookups = 40
        var counter = 0
        while index==nil && counter <= maxLookups{
            counter = counter + 1
            if day<31 {
                day = day + 1
            } else if month<12 {
                day = 1
                month = month + 1
            } else {
                day = 1
                month = 1
                year = year + 1
            }
            index = schoolDays.index(where:{$0[3]==year&&$0[1]==month&&$0[2]==day})
        }
        if index == nil {
            index = 0
        }
        let cycleDayToSave = schoolDays[index!][5]
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(cycleDayToSave, forKey: "today")
        return index!
    }
}
