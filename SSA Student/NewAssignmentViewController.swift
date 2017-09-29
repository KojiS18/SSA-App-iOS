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
    
    @IBOutlet weak var classPicker: UIPickerView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    var array:Array = [C1Name, C2Name, C3Name, C4Name, C5Name, C6Name]
    var selectedClassValue:Int = 0
    var clickedCellPath:Int = 2
    var dueDate:Date = Date()
    
    var doNotDelete:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.assignmentTextField.delegate = self
        notesTextView.delegate = self
        UserDefaults.standard.synchronize()
        //Sets values of input objects to either be new things or saved values
        dueDate = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")![clickedCellPath] as! Date
        var namesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNamesArray")!
        var dueDateArray:Array = UserDefaults.standard.array(forKey: "AssignmentDueDateArray")!
        var classArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        var notesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        selectedClassValue = classArray[clickedCellPath] as! Int
        notesTextView.text = notesArray[clickedCellPath] as! String
        assignmentTextField.text = namesArray[clickedCellPath] as! String
        dueDatePicker.date = dueDateArray[clickedCellPath] as! Date
        let previousClass = classArray[clickedCellPath] as! Int
        classPicker.selectRow(previousClass, inComponent: 0, animated: false)
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
        dueDateArray[clickedCellPath] = dueDate
        UserDefaults.standard.set(dueDateArray, forKey: "AssignmentDueDateArray")
        var classArray:Array = UserDefaults.standard.array(forKey: "AssignmentClassArray")!
        classArray[clickedCellPath] = selectedClassValue
        UserDefaults.standard.set(classArray, forKey: "AssignmentClassArray")
        var notesArray:Array = UserDefaults.standard.array(forKey: "AssignmentNotesArray")!
        notesArray[clickedCellPath] = notesTextView.text!
        UserDefaults.standard.set(notesArray, forKey: "AssignmentNotesArray")
        UserDefaults.standard.synchronize()
        
        dismiss(animated: true, completion: nil)

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedClassValue = row
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
    
    @IBAction func dueDateValueChanged(_ sender: Any) {
        dueDatePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let selectedDate = dueDatePicker.date
        dueDate = selectedDate
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
        UserDefaults.standard.synchronize()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
}
