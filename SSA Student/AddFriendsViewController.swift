//
//  AddFriendsViewController.swift
//  SSA Student
//
//  Created by pro admin on 9/23/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import CoreImage

class AddFriendsViewController: UIViewController, UITextFieldDelegate {
    
    var myName: String = ""
    @IBOutlet weak var ownQRcode: UIImageView!
    
    
    @IBOutlet weak var warning: UILabel!
    
    @IBOutlet weak var yourName: UITextField!
    
    @IBOutlet weak var blankImage: UIImageView!
    
    
    @IBOutlet weak var ownTextCode: UITextField!
    
    @IBAction func copyToClip(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = getMyCode()
        
    }
    
    @IBAction func finishChangingName(_ sender: UITextField) {
        if sender.tag == 2 {
            if let a = sender.text {
                if a != "" {
                    myName = a
                    
                    let defaults:UserDefaults = UserDefaults.standard
                    defaults.set(a, forKey: "myName")
                    //resignKeyboard()
                    generateMyCode()
                }
            }
        }
        
    }
    
    
    @IBOutlet weak var textCodeFromFriend: UITextField!
    
    func sameAdd() {
        if let text = textCodeFromFriend.text {
            
            if text != "" {
                var freeArray = text.split(separator: ",")
                var counter = 0
                var stringCounter = 0
                for each in freeArray {
                    if Int(each) != nil {
                        counter = counter + 1
                        print("has \(counter) valid frees")
                    } else {
                        stringCounter = stringCounter + 1
                    }
                }
                print(freeArray)
                if counter > 1 && stringCounter==1 {
                    let defaults:UserDefaults = UserDefaults.standard
                    if var namesArray = defaults.array(forKey: "namesArray") {
                        namesArray.append(String(freeArray[0]))
                        defaults.set(namesArray, forKey: "namesArray")
                        print("exist")
                        print(namesArray)
                    } else {
                        let newNamesArray = [String(freeArray[0])]
                        defaults.set(newNamesArray, forKey: "namesArray")
                        print(newNamesArray)
                    }
                    var newUserFrees: [Bool] = Array(repeating: false, count: 64)
                    //freeArray.remove(at: 0)
                    for num in freeArray {
                        if let n = Int(num) {
                            newUserFrees[n] = true
                        }
                    }
                    print(newUserFrees)
                    if let all = defaults.array(forKey:
                        "all") {
                        var allFriends = all as! [[Bool]]
                        allFriends.append(newUserFrees)
                        defaults.set(allFriends, forKey: "all")
                        print(allFriends)
                    } else {
                        defaults.set([newUserFrees], forKey: "all")
                        print([newUserFrees])
                        print("creating a new one")
                    }
                    textCodeFromFriend.text = ""
                    resignKeyboard()
                    let alertController = UIAlertController(title: "Done", message: "You have successfully added \(freeArray[0]), who has \(counter) frees in a cycle", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okButton)
                    self.present(alertController,animated: true, completion: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Wrong format", message: "Code format is not valid. Input is \(text)", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okButton)
                    self.present(alertController,animated: true, completion: nil)
                }
            }
            
            
            
        }
        resignKeyboard()
    }
    @IBAction func addFriendThruTextCode(_ sender: UIButton) {
        
        if let text = textCodeFromFriend.text {
            
            if text != "" {
                var freeArray = text.split(separator: ",")
                var counter = 0
                var stringCounter = 0
                for each in freeArray {
                    if Int(each) != nil {
                        counter = counter + 1
                        print("has \(counter) valid frees")
                    } else {
                        stringCounter = stringCounter + 1
                    }
                }
                print(freeArray)
                if counter > 1 && stringCounter==1 {
                let defaults:UserDefaults = UserDefaults.standard
                if var namesArray = defaults.array(forKey: "namesArray") {
                    namesArray.append(String(freeArray[0]))
                    defaults.set(namesArray, forKey: "namesArray")
                    print("exist")
                    print(namesArray)
                } else {
                    let newNamesArray = [String(freeArray[0])]
                    defaults.set(newNamesArray, forKey: "namesArray")
                    print(newNamesArray)
                }
                var newUserFrees: [Bool] = Array(repeating: false, count: 64)
                //freeArray.remove(at: 0)
                for num in freeArray {
                    if let n = Int(num) {
                        newUserFrees[n] = true
                    }
                }
                print(newUserFrees)
                if let all = defaults.array(forKey:
                    "all") {
                    var allFriends = all as! [[Bool]]
                    allFriends.append(newUserFrees)
                    defaults.set(allFriends, forKey: "all")
                    print(allFriends)
                } else {
                    defaults.set([newUserFrees], forKey: "all")
                    print([newUserFrees])
                    print("creating a new one")
                }
                textCodeFromFriend.text = ""
                resignKeyboard()
                let alertController = UIAlertController(title: "Done", message: "You have successfully added \(freeArray[0]), who has \(counter) frees in a cycle", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController,animated: true, completion: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Wrong format", message: "Code format is not valid. Input is \(text)", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okButton)
                    self.present(alertController,animated: true, completion: nil)
                }
            }
            
        
            
        }
    }
    
    
    func readWholeCycle()->[[String]]?{
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("wholeCycle.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                
                if let jdata = fileManager.contents(atPath: (jsonFilePath?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object = json as? [[String]] {
                        
                        //print("whole cycle read")
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
            //do stuff if there
        }
        print("readwholecycle fail")
        return nil
    }
    func getMyCode()->String?{
        
        if let w = readWholeCycle() {
            var myCode = ""
            let defaults:UserDefaults = UserDefaults.standard
            if let myn = defaults.string(forKey: "myName") {
                yourName.text = myn
                myCode.append(myn)
            } else {
                return nil
            }
            for day in 0...7 {
                for period in 0...7{
                    switch w[day][period] {
                    case "Free", "Lunch", "free", "lunch", "free ", " free", " Free", "Free ":
                        let str = "," + String(day * 8 + period)
                        myCode.append(str)
                        
                    default: break
                    }
                }
            }
            return myCode
        } else {
            return nil
        }
        
    }
    
    func generateMyCode(){
        if let t = getMyCode() {
            warning.isHidden = true
            ownTextCode.adjustsFontSizeToFitWidth = true
            ownTextCode.minimumFontSize = 10.0
            let start = t.index(t.startIndex, offsetBy: 30)
            let shortEnoughForDisplay = t.substring(to: start)
            ownTextCode.text = shortEnoughForDisplay + "..."
            let data = t.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")!
            
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("L", forKey: "inputCorrectionLevel")
            if let ci = filter.outputImage {
                let scaleX = ownQRcode.frame.size.width / ci.extent.size.width
                let scaleY = ownQRcode.frame.size.height / ci.extent.size.height
                
                let transformedImage = ci.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
                
                
                ownQRcode.image = UIImage(ciImage: transformedImage)
            } else {
                warning.isHidden = false
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        blankImage.backgroundColor = UIColor.clear
        yourName.delegate = self
        textCodeFromFriend.delegate = self
        generateMyCode()
            
           // ownTextCode.text = t
        }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            let keyboardToolBar = UIToolbar()
            keyboardToolBar.barStyle = UIBarStyle.default
            keyboardToolBar.isTranslucent = true;
            let doneBtn = UIBarButtonItem(title: "Enter", style: UIBarButtonItemStyle.done, target:self, action: #selector(AddFriendsViewController.sameAdd))
            
            let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            
            let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target:self, action: #selector(AddFriendsViewController.resignKeyboard))
            keyboardToolBar.setItems([cancel,flex,doneBtn], animated: true)
            keyboardToolBar.sizeToFit()
            
            
            textField.inputAccessoryView = keyboardToolBar
            return true;
        } else {
            let keyboardToolBar = UIToolbar()
            keyboardToolBar.barStyle = UIBarStyle.default
            keyboardToolBar.isTranslucent = true;
            let doneBtn = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target:self, action: #selector(AddFriendsViewController.resignKeyboard))
            
            let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            
            //let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target:self, action: #selector(AddFriendsViewController.resignKeyboard))
            keyboardToolBar.setItems([flex,doneBtn], animated: true)
            keyboardToolBar.sizeToFit()
            
            
            textField.inputAccessoryView = keyboardToolBar
            return true;
        }
        
    }
    
    func resignKeyboard(){
        self.view.endEditing(true)
        
    }
        
        
        
        
        //ownQRcode

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
