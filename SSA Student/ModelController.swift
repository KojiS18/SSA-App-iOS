//
//  ModelController.swift
//  Alpha
//
//  Created by admin on 7/14/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

//NOTE
//User inputs all period 4s, save period 4s to file, generate wholecycle, save wholecycle  to file. user can change wholecycle (period by period) or period4s (all of a particular class)
//whenever we save period 4s,we need to change saved wholecycle
//so we need to have an updateCycle function that reads wholecycle and p4s,

//create a schedule--input p4s--generate whole cycle--change whole cycle.
//after pressing the finish button, preapre the p4s string, pass it to generatewhole, pass the result to writewholecycle
//wholecycle should be a computed variable that comes from readwholecycle
//when want to make changes, read

class ModelController: NSObject, UIPageViewControllerDataSource {
    
    //var pageData: [String] = []
    
    var schoolDaysInfo: [[Int]]
    var wholeCycle: [[String]]
    var schoolDaysInfo2: [[String]]
    override init() {
        
        let failsafe2 = [[0,8,29,2017,2,0,1], [1,8,30,2017,3,1,0], [2,8,31,2017,4,2,0], [3,9,1,2017,5,3,0], [4,9,5,2017,2,4,0], [5,9,6,2017,3,5,0], [6,9,7,2017,4,6,0], [7,9,8,2017,5,7,0], [8,9,11,2017,1,8,0], [9,9,12,2017,2,1,0], [10,9,13,2017,3,2,0], [11,9,14,2017,4,3,0], [12,9,15,2017,5,4,0], [13,9,18,2017,1,5,0], [14,9,19,2017,2,6,0], [15,9,20,2017,3,7,0], [16,9,22,2017,5,8,0], [17,9,25,2017,1,1,0], [18,9,26,2017,2,2,0], [19,9,27,2017,3,3,0], [20,9,28,2017,4,4,0], [21,9,29,2017,5,5,0], [22,10,2,2017,1,6,0], [23,10,3,2017,2,7,0], [24,10,4,2017,3,8,0], [25,10,5,2017,4,1,0], [26,10,6,2017,5,2,0], [27,10,10,2017,2,3,0], [28,10,11,2017,3,0,2], [29,10,12,2017,4,4,0], [30,10,13,2017,5,5,0], [31,10,16,2017,1,6,0], [32,10,17,2017,2,7,0], [33,10,18,2017,3,8,0], [34,10,19,2017,4,1,0], [35,10,20,2017,5,2,0], [36,10,23,2017,1,3,0], [37,10,24,2017,2,4,0], [38,10,25,2017,3,5,0], [39,10,26,2017,4,6,0], [40,10,27,2017,5,7,0], [41,10,30,2017,1,8,0], [42,10,31,2017,2,1,0], [43,11,1,2017,3,2,0], [44,11,2,2017,4,3,0], [45,11,3,2017,5,4,0], [46,11,6,2017,1,5,0], [47,11,7,2017,2,6,0], [48,11,8,2017,3,7,0], [49,11,9,2017,4,8,0], [50,11,10,2017,5,1,0], [51,11,13,2017,1,2,0], [52,11,14,2017,2,3,0], [53,11,15,2017,3,0,3], [54,11,16,2017,4,0,4], [55,11,20,2017,1,0,5], [56,11,21,2017,2,4,0], [57,11,28,2017,2,5,0], [58,11,29,2017,3,6,0], [59,11,30,2017,4,7,0], [60,12,1,2017,5,8,0], [61,12,4,2017,1,1,0], [62,12,5,2017,2,2,0], [63,12,6,2017,3,3,0], [64,12,7,2017,4,4,0], [65,12,8,2017,5,5,0], [66,12,11,2017,1,6,0], [67,12,12,2017,2,7,0], [68,12,13,2017,3,8,0], [69,12,14,2017,4,1,0], [70,12,15,2017,5,2,0], [71,12,18,2017,1,3,0], [72,12,19,2017,2,4,0], [73,12,20,2017,3,5,0], [74,12,21,2017,4,6,0], [75,12,22,2017,5,7,6], [76,1,8,2018,1,8,0], [77,1,9,2018,2,1,0], [78,1,10,2018,3,2,0], [79,1,11,2018,4,3,0], [80,1,12,2018,5,4,0], [81,1,16,2018,2,5,0], [82,1,17,2018,3,6,0], [83,1,18,2018,4,7,0], [84,1,19,2018,5,8,0], [85,1,22,2018,1,1,0], [86,1,23,2018,2,2,0], [87,1,24,2018,3,3,0], [88,1,25,2018,4,4,0], [89,1,26,2018,5,5,0], [90,1,29,2018,1,6,0], [91,1,30,2018,2,7,0], [92,1,31,2018,3,8,0], [93,2,1,2018,4,1,0], [94,2,2,2018,5,2,0], [95,2,5,2018,1,3,0], [96,2,6,2018,2,4,0], [97,2,7,2018,3,5,0], [98,2,8,2018,4,6,0], [99,2,9,2018,5,7,0], [100,2,12,2018,1,8,0], [101,2,13,2018,2,1,0], [102,2,14,2018,3,2,0], [103,2,15,2018,4,3,0], [104,2,16,2018,5,4,0], [105,2,20,2018,2,5,0], [106,2,21,2018,3,0,3], [107,2,22,2018,4,0,4], [108,2,26,2018,1,0,5], [109,2,27,2018,2,6,0], [110,2,28,2018,3,7,0], [111,3,1,2018,4,8,0], [112,3,2,2018,5,1,0], [113,3,5,2018,1,2,0], [114,3,6,2018,2,3,0], [115,3,7,2018,3,4,0], [116,3,8,2018,4,5,0], [117,3,9,2018,5,6,0], [118,3,12,2018,1,7,0], [119,3,13,2018,2,8,0], [120,3,14,2018,3,1,0], [121,3,15,2018,4,2,0], [122,3,16,2018,5,3,0], [123,4,3,2018,2,4,0], [124,4,4,2018,3,5,0], [125,4,5,2018,4,6,0], [126,4,6,2018,5,7,0], [127,4,9,2018,1,8,0], [128,4,10,2018,2,1,0], [129,4,11,2018,3,2,0], [130,4,12,2018,4,3,0], [131,4,13,2018,5,4,0], [132,4,16,2018,1,5,0], [133,4,17,2018,2,6,0], [134,4,18,2018,3,7,0], [135,4,19,2018,4,8,0], [136,4,20,2018,5,1,0], [137,4,23,2018,1,2,0], [138,4,24,2018,2,3,0], [139,4,25,2018,3,4,0], [140,4,26,2018,4,5,0], [141,4,27,2018,5,6,0], [142,4,30,2018,1,7,0], [143,5,1,2018,2,8,0], [144,5,2,2018,3,1,0], [145,5,3,2018,4,2,0], [146,5,4,2018,5,3,0], [147,5,7,2018,1,4,0], [148,5,8,2018,2,5,0], [149,5,9,2018,3,6,0], [150,5,10,2018,4,7,0], [151,5,11,2018,5,8,0], [152,5,14,2018,1,1,0], [153,5,15,2018,2,2,0], [154,5,16,2018,3,3,0], [155,5,17,2018,4,4,0], [156,5,18,2018,5,5,0], [157,5,21,2018,1,6,0], [158,5,22,2018,2,7,0], [159,5,23,2018,3,8,0], [160,5,24,2018,4,1,0], ]
        let failsafe = [["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""]]
        let failsafe3: [[String]] = [
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            [],
            []
            ]
        wholeCycle = failsafe
        schoolDaysInfo = failsafe2
        schoolDaysInfo2 = failsafe3
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("wholeCycle.json")
        let jsonFilePath2 = documentsDirectoryPath.appendingPathComponent("schoolDaysInfo.json")
        let jsonFilePath3 = documentsDirectoryPath.appendingPathComponent("schoolDaysInfo2.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        if fileManager.fileExists(atPath: (jsonFilePath2?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                if let jdata = fileManager.contents(atPath: (jsonFilePath2?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object2 = json as? [[Int]] {
                        
                        //print(object)
                        schoolDaysInfo = object2
                        
                    } else {
                        print("error1")
                        print("JSON is invalid2")
                        //wholeCycle = failsafe
                    }
                } else {
                    print("error3")
                    //wholeCycle = failsafe
                }
            } catch {
                print("error4")
                print(error.localizedDescription)
                //wholeCycle = failsafe
            }
        }
        
        if fileManager.fileExists(atPath: (jsonFilePath3?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                if let jdata = fileManager.contents(atPath: (jsonFilePath3?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object4 = json as? [[String]] {
                        
                        //print(object)
                        schoolDaysInfo2 = object4
                        //print("info 2 read")
                    } else {
                        print("error1")
                        print("JSON is invalid2")
                        //wholeCycle = failsafe
                    }
                } else {
                    print("error3")
                    //wholeCycle = failsafe
                }
            } catch {
                print("error4")
                print(error.localizedDescription)
                //wholeCycle = failsafe
            }
        }
        
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                if let jdata = fileManager.contents(atPath: (jsonFilePath?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object = json as? [[String]] {
                        
                        //print(object)
                        wholeCycle = object
                        //print("whole changed")
                    } else {
                        print("error5")
                        print("error6")
                        //wholeCycle = failsafe
                    }
                } else {
                    print("error7")
                    //wholeCycle = failsafe
                }
            } catch {
                print("error8")
                print(error.localizedDescription)
                //wholeCycle = failsafe
            }
        }
        
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.schoolDaysInfo.count == 0) || (index >= self.schoolDaysInfo.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        //dataViewController.dataObject = self.pageData[index]
        if self.schoolDaysInfo[index][6] != 0 {
            let dex = self.schoolDaysInfo[index][6]
            dataViewController.specialDayTypeInfo = self.schoolDaysInfo2[dex]
        }
        dataViewController.todayInfo = self.schoolDaysInfo[index]
        dataViewController.wholeCycle = self.wholeCycle
        
        //dataViewController.view
        
        return dataViewController
    }
    
    func indexOfViewController(_ viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        //return pageData.index(of: viewController.dataObject) ?? NSNotFound
        return viewController.todayInfo[0]
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.schoolDaysInfo.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func makeGetCall() {
        
        // Set up the URL request
        let todoEndpoint: String = "https://sites.google.com/site/ssamobilehelper/schooldaysinfo/keepnameunchanged.txt?attredirects=0&d=1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            //print("urlrequest")
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error as Any)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[Int]] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it\
                
                //print("download successful, we have the school days")
                self.writeSchoolDays(arraytowrite: todo)
                //print("school days method finished")
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        //print("task resumed")
        
        
    }
    
    
    
    func makeGetCall2() {
        
        // Set up the URL request
        let todoEndpoint: String = "https://sites.google.com/site/ssamobilehelper/schooldaysinfo/customschedules.txt?attredirects=0&d=1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            //print("urlrequest")
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error as Any)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String]] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it\
                
                //print("download successful, we have the school days")
                self.writeSchoolDays2(arraytowrite: todo)
                //print("school days method finished")
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        //print("task resumed")
        
        
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
    
    func ReadSchoolDays2()->[[String]]?{
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("schoolDaysInfo2.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                
                if let jdata = fileManager.contents(atPath: (jsonFilePath?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object = json as? [[String]] {
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
    
    func writeSchoolDays(arraytowrite: [[Int]]){
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("schoolDaysInfo.json")
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
            jsonData = try JSONSerialization.data(withJSONObject: arraytowrite, options: JSONSerialization.WritingOptions()) as NSData
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
            //print("school days written")
            if let c = ReadSchoolDays() {
                self.schoolDaysInfo = c
                //print("school days to memory")
            }
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
    
    
    func writeSchoolDays2(arraytowrite: [[String]]){
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("schoolDaysInfo2.json")
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
            jsonData = try JSONSerialization.data(withJSONObject: arraytowrite, options: JSONSerialization.WritingOptions()) as NSData
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
            //print("school days 2 written")
            if let c = ReadSchoolDays2() {
                self.schoolDaysInfo2 = c
                //print("school days 2 to memory")
            }
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
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
            //print("JSON data was written to the file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
    
    func deleteWholeCycle() {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("wholeCycle.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath?.absoluteString)!, contents: nil, attributes: nil)
            if created {
                //print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        }
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.truncateFile(atOffset: 0)
            
            //print("JSON data was written to the file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
        wholeCycle = [["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""]]
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
 
    /*
    func ReadPeriod4s()->[String]{
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("period4s.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            do {
                
                if let jdata = fileManager.contents(atPath: (jsonFilePath?.absoluteString)!) {
                    
                    let json = try JSONSerialization.jsonObject(with: jdata, options: [])
                    if let object = json as? [String] {
                        
                        //print(object)
                        return object
                    } else {
                        print("from readp4s: JSON is invalid")
                    }
                } else {
                    
                    
                }
            } catch {
                print("error from readp4s:")
                print(error.localizedDescription)
            }
        } else {
            //do something if there's no saved p4s (like pop up an enter schedule view)
            return []
        }
        
        return []
    }
    
    func updateWholeCycle(){
        let p4s = ReadPeriod4s()
        var whole = readWholeCycle()
        
        
    }
 */
    
    /*
    func WritePeriod4s(arraytowrite: [String]){
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("period4s.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath?.absoluteString)!, contents: nil, attributes: nil)
            if created {
                print("writep4s: File created ")
            } else {
                print("writep4s: Couldn't create file for some reason")
            }
        } else {
            print("writep4s: File already exists")
        }
        
        // creating JSON out of the above array
        var jsonData: NSData!
        do {
            jsonData = try JSONSerialization.data(withJSONObject: arraytowrite, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            print("writep4s:")
            print(jsonString ?? "ERROR")
        } catch let error as NSError {
            print("writep4s: Array to JSON conversion failed: \(error.localizedDescription)")
        }
        
        // Write that JSON to the file created earlier
        
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.write(jsonData as Data)
            print("writep4s: JSON data was written to the file successfully!")
        } catch let error as NSError {
            print("writep4s: Couldn't write to file: \(error.localizedDescription)")
        }
    }
 */
    //[d1p4,AB,S,d2p4,BC,
    /*
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
        for i in 0...7{
            switch using[i * 3 + 1]{
                case "AB":
                    wholeCycle[i].insert("Lunch", at: 4)
                    wholeCycle[i].insert(wholeCycle[i][3], at: 3)
                case "BC":
                    wholeCycle[i].insert("Lunch", at: 3)
                    wholeCycle[i].insert(wholeCycle[i][4], at: 4)
                case "Free":
                    wholeCycle[i].insert("Free", at: 3)
                    wholeCycle[i].insert(wholeCycle[i][4], at: 4)
                default:
                    wholeCycle[i].insert("error", at: 3)
                    wholeCycle[i].insert(wholeCycle[i][4], at: 4)
            }
            if using[i * 3 + 2] == "Science" {
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
            }
        }
        return wholeCycle

    }
 */

}

