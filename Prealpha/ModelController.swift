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

    
    var d: [[Int]] = []
    var a: [String] = []
    var alldp: [[String]] = []

    override init() {
        super.init()
        // Create the data model.
        
        d = [[8, 29, 17, 2, 1, 0], [8, 30, 17, 3, 1, 1], [8, 31, 17, 4, 2, 2], [9, 1, 17, 5, 3, 3], [9, 4, 17, 1, 4, 4], [9, 5, 17, 2, 5, 5], [9, 6, 17, 3, 6, 6], [9, 7, 17, 4, 7, 7], [9, 8, 17, 5, 8, 8], [9, 11, 17, 1, 1, 9], [9, 12, 17, 2, 2, 10], [9, 13, 17, 3, 3, 11], [9, 14, 17, 4, 4, 12], [9, 15, 17, 5, 5, 13], [9, 18, 17, 1, 6, 14], [9, 19, 17, 2, 7, 15], [9, 20, 17, 3, 8, 16], [9, 21, 17, 4, 1, 17], [9, 22, 17, 5, 2, 18], [9, 25, 17, 1, 3, 19], [9, 26, 17, 2, 4, 20], [9, 27, 17, 3, 5, 21], [9, 28, 17, 4, 6, 22], [9, 29, 17, 5, 7, 23], [10, 2, 17, 1, 8, 24], [10, 3, 17, 2, 1, 25], [10, 4, 17, 3, 2, 26], [10, 5, 17, 4, 3, 27], [10, 6, 17, 5, 4, 28], [10, 9, 17, 1, 5, 29], [10, 10, 17, 2, 6, 30], [10, 11, 17, 3, 7, 31], [10, 12, 17, 4, 8, 32], [10, 13, 17, 5, 1, 33], [10, 16, 17, 1, 2, 34], [10, 17, 17, 2, 3, 35], [10, 18, 17, 3, 4, 36], [10, 19, 17, 4, 5, 37], [10, 20, 17, 5, 6, 38], [10, 23, 17, 1, 7, 39], [10, 24, 17, 2, 8, 40], [10, 25, 17, 3, 1, 41], [10, 26, 17, 4, 2, 42], [10, 27, 17, 5, 3, 43], [10, 30, 17, 1, 4, 44], [10, 31, 17, 2, 5, 45]]
        a = ["English1","History2","Math3","French4","Art5","Free6","Free7","CS8"]
        alldp.append([a[4],a[7],a[2],a[0],a[3],a[6]])
        alldp.append([a[5],a[0],a[3],a[1],a[4],a[7]])
        alldp.append([a[6],a[1],a[4],a[2],a[5],a[0]])
        alldp.append([a[7],a[2],a[5],a[3],a[6],a[1]])
        alldp.append([a[0],a[3],a[6],a[4],a[7],a[2]])
        alldp.append([a[1],a[4],a[7],a[5],a[0],a[3]])
        alldp.append([a[2],a[5],a[0],a[6],a[1],a[4]])
        alldp.append([a[3],a[6],a[1],a[7],a[2],a[5]])
    }
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.d.count == 0) || (index >= self.d.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        dataViewController.day = self.d[index][4]
        dataViewController.indexpage = self.d[index][5]
        dataViewController.completedate = "Day \(self.d[index][4]), \(self.d[index][0])/\(self.d[index][1])/\(self.d[index][2])"
        dataViewController.all = alldp
        return dataViewController
    }

    func indexOfViewController(_ viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        
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
        if index == self.d.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

