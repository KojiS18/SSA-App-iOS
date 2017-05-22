//
//  ModelController.swift
//  Prealpha
//
//  Created by Peter W on 5/4/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var dayTypeDict = [0:"1005community",
                       1:"tuesday",
                       2:"1005class",
                       3:"1005advisory",
                       4:"1015snowdelay",
                       5:"day0award",
                       6:"day0convo"]
    var schoolDaysInfo: [[Int]] = []
    var p4OfEachDayName: [String] = []
    var wholeCycle: [[String]] = []
    var p4OfEachDayAB: [Bool] = []
    var p4OfEachDayScience: [Bool] = []

    override init() {
        super.init()
        // Create the data model.
        //0 index
        //1 mm
        //2 dd
        //3 yy
        //4 weekday
        //5 cycleday
        //6 day type (pre defined types)
        schoolDaysInfo = [[0, 8, 29, 17, 2, 1, 0], [1, 8, 30, 17, 3, 1, 0], [2, 8, 31, 17, 4, 2, 0], [3, 9, 1, 17, 5, 3, 0], [4, 9, 4, 17, 1, 4, 0], [5, 9, 5, 17, 2, 5, 0], [6, 9, 6, 17, 3, 6, 0], [7, 9, 7, 17, 4, 7, 0], [8, 9, 8, 17, 5, 8, 0], [9, 9, 11, 17, 1, 1, 0], [10, 9, 12, 17, 2, 2, 0], [11, 9, 13, 17, 3, 3, 0], [12, 9, 14, 17, 4, 4, 0], [13, 9, 15, 17, 5, 5, 0], [14, 9, 18, 17, 1, 6, 0], [15, 9, 19, 17, 2, 7, 0], [16, 9, 20, 17, 3, 8, 0], [17, 9, 21, 17, 4, 1, 0], [18, 9, 22, 17, 5, 2, 0], [19, 9, 25, 17, 1, 3, 0], [20, 9, 26, 17, 2, 4, 0], [21, 9, 27, 17, 3, 5, 0], [22, 9, 28, 17, 4, 6, 0], [23, 9, 29, 17, 5, 7, 0], [24, 10, 2, 17, 1, 8, 0], [25, 10, 3, 17, 2, 1, 0], [26, 10, 4, 17, 3, 2, 0], [27, 10, 5, 17, 4, 3, 0], [28, 10, 6, 17, 5, 4, 0], [29, 10, 9, 17, 1, 5, 0], [30, 10, 10, 17, 2, 6, 0], [31, 10, 11, 17, 3, 7, 0], [32, 10, 12, 17, 4, 8, 0], [33, 10, 13, 17, 5, 1, 0], [34, 10, 16, 17, 1, 2, 0], [35, 10, 17, 17, 2, 3, 0], [36, 10, 18, 17, 3, 4, 0], [37, 10, 19, 17, 4, 5, 0], [38, 10, 20, 17, 5, 6, 0], [39, 10, 23, 17, 1, 7, 0], [40, 10, 24, 17, 2, 8, 0], [41, 10, 25, 17, 3, 1, 0], [42, 10, 26, 17, 4, 2, 0], [43, 10, 27, 17, 5, 3, 0], [44, 10, 30, 17, 1, 4, 0], [45, 10, 31, 17, 2, 5, 0]]
        
        p4OfEachDayName = ["English1","History2","Math3","French4","Art5","Free6","Free7","CS8"]
        p4OfEachDayAB = [true,false,false,false,true,true,true,false]
        p4OfEachDayScience = [true,false,false,false,true,true,true,false]
        wholeCycle.append([p4OfEachDayName[4],p4OfEachDayName[7],p4OfEachDayName[2],p4OfEachDayName[0],p4OfEachDayName[3],p4OfEachDayName[6]])
        wholeCycle.append([p4OfEachDayName[5],p4OfEachDayName[0],p4OfEachDayName[3],p4OfEachDayName[1],p4OfEachDayName[4],p4OfEachDayName[7]])
        wholeCycle.append([p4OfEachDayName[6],p4OfEachDayName[1],p4OfEachDayName[4],p4OfEachDayName[2],p4OfEachDayName[5],p4OfEachDayName[0]])
        wholeCycle.append([p4OfEachDayName[7],p4OfEachDayName[2],p4OfEachDayName[5],p4OfEachDayName[3],p4OfEachDayName[6],p4OfEachDayName[1]])
        wholeCycle.append([p4OfEachDayName[0],p4OfEachDayName[3],p4OfEachDayName[6],p4OfEachDayName[4],p4OfEachDayName[7],p4OfEachDayName[2]])
        wholeCycle.append([p4OfEachDayName[1],p4OfEachDayName[4],p4OfEachDayName[7],p4OfEachDayName[5],p4OfEachDayName[0],p4OfEachDayName[3]])
        wholeCycle.append([p4OfEachDayName[2],p4OfEachDayName[5],p4OfEachDayName[0],p4OfEachDayName[6],p4OfEachDayName[1],p4OfEachDayName[4]])
        wholeCycle.append([p4OfEachDayName[3],p4OfEachDayName[6],p4OfEachDayName[1],p4OfEachDayName[7],p4OfEachDayName[2],p4OfEachDayName[5]])
        for i in 0...7{
            if p4OfEachDayAB[i]{
                wholeCycle[i].insert("Lunch", at: 3)
            }
            else if !p4OfEachDayAB[i]{
                wholeCycle[i].insert("Lunch", at: 4)
            }
        }
    }
    
    //returns a page (dataViewController) for the given index
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        
        //if there's no stuff in the data array, or no more stuff in the array to display, return nil
        if (self.schoolDaysInfo.count == 0) || (index >= self.schoolDaysInfo.count) {
            return nil
        }

        // Create a new view controller and pass data to the viewcontroller object's instance variables
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        dataViewController.todayDayType = self.schoolDaysInfo[index][6]
        dataViewController.day = self.schoolDaysInfo[index][5]
        dataViewController.indexpage = self.schoolDaysInfo[index][0]
        dataViewController.completedate = "Day \(self.schoolDaysInfo[index][5]), \(self.schoolDaysInfo[index][1])/\(self.schoolDaysInfo[index][2])/\(self.schoolDaysInfo[index][3])"
        dataViewController.all = wholeCycle
        return dataViewController
    }

    //return the dataviewcontroller object's instance variable "indexpage"
    func indexOfViewController(_ viewController: DataViewController) -> Int {
        return viewController.indexpage
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
        //if there's no more data to display, stops returning pages
        if index == self.schoolDaysInfo.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

