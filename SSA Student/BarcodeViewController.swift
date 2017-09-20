//
//  BarcodeViewController.swift
//  Alpha
//
//  Created by pro admin on 7/30/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import RSBarcodes
import AVFoundation

class BarcodeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topbar: UIImageView!
    var barImage: UIImageView? = nil
    @IBAction func dismissKeyboard(_ sender: UIButton) {
        a.resignFirstResponder()
    }
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteBarcode(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Delete Barcode", message: "Are you sure you would like to delete your barcode?", preferredStyle: .actionSheet)
        let delButton = UIAlertAction(title: "Delete", style: .destructive, handler: {(action)->Void in
            //self.barImage!.image = nil
            print(type(of: self.barImage))
            self.barImage?.isHidden = true
            print(type(of: self.barImage))
            self.barImage?.removeFromSuperview()
            print(type(of: self.barImage))
            self.barImage?.image = nil
            print(type(of: self.barImage))
            self.deleteButton.isHidden = true
            
            let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
            
            let jsonFilePath = documentsDirectoryPath.appendingPathComponent("barcode.json")
            _ = FileManager.default
            //var isDirectory: ObjCBool = false
            do {
                
                let file = try FileHandle(forWritingTo: jsonFilePath!)
                file.truncateFile(atOffset: 0)
                //print("JSON data was written to the file successfully!")
            } catch let error as NSError {
                print("Couldn't delete file: \(error.localizedDescription)")
            }
            
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action)->Void in
            
        })
        
        alertController.addAction(cancelButton)
        alertController.addAction(delButton)
        self.present(alertController,animated: true, completion: nil)
        
        
    }
    
    
    var currentBrightness: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let color: UIColor = UIColor(red: (29/255.0), green: (54/255.0), blue: (95/255.0), alpha: 1.0)
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: self.view.bounds.width, height: 44))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.topbar.image = image!
        self.a.delegate = self
        a.keyboardType = .numberPad
        
        // Do any additional setup after loading the view.
    }
    
    func createAndDisplay(str: String) {
        var y: CGFloat = 0.0
        var x: CGFloat = 0.0
        var w: CGFloat = 0.0
        var h: CGFloat = 0.0
        switch self.view.bounds.width {
        case 320: y = 190.0
            h = 190.0
            x = 20
            w = 280
        case 375: y = 250.0
            h = 220.0
            x = 0
            w = 375
        case 414: y = 280.0
            h = 240.0
            x = 0
            w = 414
        default: y = 300.0
            h = 240.0
            x = 0
            w = self.view.bounds.width
            
        }
        
        let frame = CGRect(x: x, y: y, width: w, height: h)
        
        self.barImage = UIImageView(frame: frame)
        
        barImage!.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        
        let display = RSUnifiedCodeGenerator.shared.generateCode(str, machineReadableCodeObjectType: AVMetadataObjectTypeCode39Code)
        
        barImage!.image = display
        barImage?.isHidden = false
        self.view.addSubview(barImage!)
        barImage?.isHidden = false
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        let max: CGFloat = 1.0
        if UIScreen.main.brightness == max{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let b = appDelegate.bright {
                UIScreen.main.brightness = b
            }
            
        }
    }
    //func textFieldShouldBeginEditing(_ textView: UITextView) -> Bool {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.barStyle = UIBarStyle.default
        keyboardToolBar.isTranslucent = true;
        let doneBtn = UIBarButtonItem(title: "Enter", style: UIBarButtonItemStyle.done, target:self, action: #selector(BarcodeViewController.generateBar(_:)))
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target:self, action: #selector(BarcodeViewController.resignKeyboard))
        keyboardToolBar.setItems([cancel,flex,doneBtn], animated: true)
        keyboardToolBar.sizeToFit()
        
        
        textField.inputAccessoryView = keyboardToolBar
        return true;
    }
    
    func resignKeyboard(){
        self.view.endEditing(true)
        
    }
    
    
/*
    @IBAction func changeBrightness(_ sender: UIButton) {
        let max: CGFloat = 1.0
        let mid: CGFloat = 0.5
        let now = UIScreen.main.brightness
        if now.isEqual(to: max) {
            let midhigh: CGFloat = 0.8
            if currentBrightness.isLessThanOrEqualTo(midhigh) {
                UIScreen.main.brightness = currentBrightness
            } else {
                UIScreen.main.brightness = mid
            }
            
        } else {
            UIScreen.main.brightness = max
        }
    }
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func generateBar(_ sender: UIButton) {
        let str = a.text!
        if str.characters.count==12 {
            a.resignFirstResponder()
            writeBarcode(stringtowrite: str)
        
        
            barImage?.removeFromSuperview()
            
            createAndDisplay(str: str)
            
            deleteButton.isHidden = false
            
        
        } else {
            
            let alertController = UIAlertController(title: "Invalid Length", message: "SSA Student ID should be 12 digits long. Please double check and try again.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController,animated: true, completion: nil)
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.bright = UIScreen.main.brightness
        if let str = readBarcode() {
                barImage?.removeFromSuperview()
                createAndDisplay(str: str)
                
                let max: CGFloat = 1.0
                UIScreen.main.brightness = max
            
            
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBOutlet weak var a: UITextField!
    
    @IBAction func cam(_ sender: UIButton) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        let toPresent = stb.instantiateViewController(withIdentifier: "cam")
        self.present(toPresent, animated: true, completion: nil)
    }
    func writeBarcode(stringtowrite: String){
        let array = [stringtowrite]
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("barcode.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath?.absoluteString)!, contents: nil, attributes: nil)
            if created {
                //print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            //print("File already exists")
        }
        
        // creating JSON out of the above array
        var jsonData: NSData!
        do {
            jsonData = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions()) as NSData
            _ = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            //print(jsonString ?? "ERROR")
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
        
        // Write that JSON to the file created earlier
        
        do {
            
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.truncateFile(atOffset: 0)
            file.write(jsonData as Data)
            //print("JSON data was written to the file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
    func readBarcode()->String?{
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("barcode.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                
                if let jdata = fileManager.contents(atPath: (jsonFilePath?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object = json as? [String] {
                        // json is a dictionary
                        //print(object)
                        return object[0]
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
