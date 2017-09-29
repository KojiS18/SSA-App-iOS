//
//  ChangeAllTopbarViewController.swift
//  Alpha
//
//  Created by pro admin on 9/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ChangeAllTopbarViewController: UIViewController {

    var child: ChangeAllTableViewController?
    var originalNames: [String] = []
    var originalAB: [Bool] = []
    var originalNor: [Bool] = []
    @IBAction func cancelView(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneChanging(_ sender: UIButton) {
        child?.view.endEditing(true)
        var newAllPeriod4s: [String] = []
        for n in 0...7{
            
            
            let name = child!.names[n]
            let isAB = child!.isAB[n]
            let isNor = child!.isNormal[n]
            //let isFree = cellN.isFree.isOn
            if name != "" && name != "free" && name != "free " && name != " free" && name != "Free " && name != " Free"{
                newAllPeriod4s.append(name)
            } else {
                //name is nil, meaning user didn't put anything
                newAllPeriod4s.append("Free")
            }
            switch isAB {
            case true: newAllPeriod4s.append("AB")
            case false: newAllPeriod4s.append("BC")
                
                
            }
            switch isNor {
            case true: newAllPeriod4s.append("Normal")
            case false: newAllPeriod4s.append("Science")
                
            }
        }
        
        let toWrite = generateWholeCycle(using: newAllPeriod4s)
        
        writeWholeCycle(with: toWrite)
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.child = InputTableViewController()
        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        self.child = (stb.instantiateViewController(withIdentifier: "allchild") as! ChangeAllTableViewController)
        child!.isNormal = originalNor
        child!.isAB = originalAB
        child!.names = originalNames
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
    
    
    
    func generateWholeCycle(using: [String]) -> [[String]]{
        //guard using.count == 24
        let p4Name = [using[0],using[3],using[6],using[9],using[12],using[15],using[18],using[21],]
        var wholeCycle: [[String]] = []
        wholeCycle.append([p4Name[4],p4Name[7],p4Name[2],p4Name[0],p4Name[3],p4Name[6]])
        wholeCycle.append([p4Name[5],p4Name[0],p4Name[3],p4Name[1],p4Name[4],p4Name[7]])
        wholeCycle.append([p4Name[6],p4Name[1],p4Name[4],p4Name[2],p4Name[5],p4Name[0]])
        wholeCycle.append([p4Name[7],p4Name[2],p4Name[5],p4Name[3],p4Name[6],p4Name[1]])
        wholeCycle.append([p4Name[0],p4Name[3],p4Name[6],p4Name[4],p4Name[7],p4Name[2]])
        wholeCycle.append([p4Name[1],p4Name[4],p4Name[7],p4Name[5],p4Name[0],p4Name[3]])
        wholeCycle.append([p4Name[2],p4Name[5],p4Name[0],p4Name[6],p4Name[1],p4Name[4]])
        wholeCycle.append([p4Name[3],p4Name[6],p4Name[1],p4Name[7],p4Name[2],p4Name[5]])
        wholeCycle.append([])
        wholeCycle.append([])
        for i in 0...7{
            switch using[i * 3 + 1]{
            case "AB":
                wholeCycle[i].insert("Lunch", at: 4)
                wholeCycle[i].insert(wholeCycle[i][3], at: 3)
                wholeCycle[8].append("AB")
            case "BC":
                wholeCycle[i].insert("Lunch", at: 3)
                wholeCycle[i].insert(wholeCycle[i][4], at: 4)
                wholeCycle[8].append("BC")
            case "Free":
                wholeCycle[i].insert("Free", at: 3)
                wholeCycle[i].insert(wholeCycle[i][4], at: 4)
            default:
                wholeCycle[i].insert("error", at: 3)
                wholeCycle[i].insert(wholeCycle[i][4], at: 4)
                wholeCycle[8].append("AB")
            }
            if using[i * 3 + 2] == "Science" {
                wholeCycle[9].append("Science")
                switch i{
                case 0:
                    wholeCycle[4][1] = wholeCycle[0][4]
                    wholeCycle[0][6] = wholeCycle[0][4]
                case 1:
                    wholeCycle[5][1] = wholeCycle[1][4]
                    wholeCycle[1][6] = wholeCycle[1][4]
                case 2:
                    wholeCycle[6][1] = wholeCycle[2][4]
                    wholeCycle[2][6] = wholeCycle[2][4]
                case 3:
                    wholeCycle[7][1] = wholeCycle[3][4]
                    wholeCycle[3][6] = wholeCycle[3][4]
                case 4:
                    wholeCycle[0][1] = wholeCycle[4][4]
                    wholeCycle[4][6] = wholeCycle[4][4]
                case 5:
                    wholeCycle[1][1] = wholeCycle[5][4]
                    wholeCycle[5][6] = wholeCycle[5][4]
                case 6:
                    wholeCycle[2][1] = wholeCycle[6][4]
                    wholeCycle[6][6] = wholeCycle[6][4]
                case 7:
                    wholeCycle[3][1] = wholeCycle[7][4]
                    wholeCycle[7][6] = wholeCycle[7][4]
                default:
                    break
                }
            } else {
                wholeCycle[9].append("Normal")
            }
        }
        return wholeCycle
        
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
