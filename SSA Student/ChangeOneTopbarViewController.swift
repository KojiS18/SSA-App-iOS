//
//  ChangeOneTopbarViewController.swift
//  Alpha
//
//  Created by pro admin on 9/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ChangeOneTopbarViewController: UIViewController {
    
    @IBOutlet weak var nameOfVC: UILabel!
    
    var child: ChangeOneTableViewController?
    var whole: [[String]] = []
    var dayN: Int = 1
    @IBAction func cancelView(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneChanging(_ sender: UIButton) {
        child?.view.endEditing(true)
        let ns = child!.names
        if child!.isAB {
            whole[dayN-1][0] = ns[0]
            whole[dayN-1][1] = ns[1]
            whole[dayN-1][2] = ns[2]
            whole[dayN-1][3] = ns[3]
            whole[dayN-1][4] = ns[3]
            whole[dayN-1][5] = "Lunch"
            whole[dayN-1][6] = ns[4]
            whole[dayN-1][7] = ns[5]
            whole[8][dayN-1] = "AB"
        } else {
            whole[dayN-1][0] = ns[0]
            whole[dayN-1][1] = ns[1]
            whole[dayN-1][2] = ns[2]
            whole[dayN-1][3] = "Lunch"
            whole[dayN-1][4] = ns[3]
            whole[dayN-1][5] = ns[3]
            whole[dayN-1][6] = ns[4]
            whole[dayN-1][7] = ns[5]
            whole[8][dayN-1] = "BC"
        }
        writeWholeCycle(with: whole)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameOfVC.text = "Change Day \(dayN)"
        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        self.child = (stb.instantiateViewController(withIdentifier: "changeone") as! ChangeOneTableViewController)
        child!.whole = self.whole
        child!.dayN = self.dayN
        if whole[dayN-1][3] == "Lunch" {
            child!.isAB = false
        } else {
            child!.isAB = true
        }
        child!.names.append(whole[dayN-1][0])
        child!.names.append(whole[dayN-1][1])
        child!.names.append(whole[dayN-1][2])
        child!.names.append(whole[dayN-1][4])
        child!.names.append(whole[dayN-1][6])
        child!.names.append(whole[dayN-1][7])
        self.addChildViewController(self.child!)
        
        self.view.addSubview(self.child!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        
        let pageViewRect = CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.bounds.height-64)
        
        
        self.child!.view.frame = pageViewRect
        
        self.child!.didMove(toParentViewController: self)
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func writeWholeCycle(with: [[String]]){
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("wholeCycle.json")
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
            jsonData = try JSONSerialization.data(withJSONObject: with, options: JSONSerialization.WritingOptions()) as NSData
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
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
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
