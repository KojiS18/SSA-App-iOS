//
//  RootViewController.swift
//  Alpha
//
//  Created by admin on 7/14/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController?
    var currentPage = 0
    var currentPageDay = 0
    var isPlayingAnimation = false
    var resetTodayCount = 0
    var atPage: Int? = nil
    //var hasSaved = false
    
    //@IBOutlet weak var topBar: UIImageView!
    //@IBOutlet weak var d: UILabel!
    
    
    @IBAction func settingsPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let wholeCycle = self._modelController?.readWholeCycle(){
            let deleteButton = UIAlertAction(title: "Delete Schedule", style: .destructive, handler: {(action)->Void in
                let alert = UIAlertController(title: "Delete Schedule", message: "Are you sure you want to delete your schedule?", preferredStyle: UIAlertControllerStyle.actionSheet)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action)->Void in
                    
                })
                let delete = UIAlertAction(title: "Delete Schedule", style: .destructive, handler: {(action)->Void in
                    self._modelController?.deleteWholeCycle()
                    
                    let currentViewController: DataViewController = self.modelController.viewControllerAtIndex(self.currentPage, storyboard: self.storyboard!)!
                    let viewControllers = [currentViewController]
                    
                    self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
                    
                })
                alert.addAction(cancel)
                alert.addAction(delete)
                self.present(alert,animated: true, completion: nil)
            })
            let editAllButton = UIAlertAction(title: "Edit All Days", style: .default, handler: {(action)->Void in
                let stb = UIStoryboard(name: "Main", bundle: nil)
                
                let toPresent = stb.instantiateViewController(withIdentifier: "allbar") as! ChangeAllTopbarViewController
                var sci: [Bool] = []
                var ab: [Bool] = []
                var names: [String] = []
    
                    for x in 0...7 {
                        names.append(wholeCycle[x][4])
                        if wholeCycle.count == 10 {
                            if wholeCycle[8].count == 8 {
                                if wholeCycle[8][x] == "BC" {
                                    ab.append(false)
                                    
                                } else {
                                    ab.append(true)
                                    
                                }
                            } else {
                                ab.append(true)
                                
                            }
                            if wholeCycle[9].count == 8 {
                                if wholeCycle[9][x] == "Science" {
                                    sci.append(true)
                                    
                                } else {
                                    sci.append(false)
                                    
                                }
                            } else {
                                sci.append(false)
                                
                            }
                        }
                        
                    }
                
                if ab.count != 8 {
                    ab = [true,true,true,true,true,true,true,true]
                    print("root fail to read ab")
                }
                if sci.count != 8 {
                    sci = [false,false,false,false,false,false,false,false]
                    print("root fail to read sci")
                }
                if names.count != 8 {
                    names = ["","","","","","","",""]
                    print("root fail to read names")
                }
                var nor: [Bool] = []
                for nth in 0...7 {
                    nor.append(!sci[nth])
                }
                
                toPresent.originalAB = ab
                toPresent.originalNor = nor
                toPresent.originalNames = names
 
                
                self.present(toPresent, animated: true, completion: nil)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action)->Void in
                
            })
            alertController.addAction(deleteButton)
            alertController.addAction(editAllButton)
            if (currentPageDay >= 1) && (currentPageDay <= 8) {
                let str = "Edit Just Day " + String(currentPageDay)
                let editTodayButton = UIAlertAction(title: str, style: .default, handler: {(action)->Void in
                    let stb = UIStoryboard(name: "Main", bundle: nil)
                    
                    let toPresent = stb.instantiateViewController(withIdentifier: "onebar") as! ChangeOneTopbarViewController
                    toPresent.whole = wholeCycle
                    toPresent.dayN = self.currentPageDay
                    self.present(toPresent, animated: true, completion: nil)
                })
                alertController.addAction(editTodayButton)
            }
            
            alertController.addAction(cancelButton)
            
        } else {
            
            let newButton = UIAlertAction(title: "New Schedule", style: .default, handler: {(action)->Void in
                let stb = UIStoryboard(name: "Main", bundle: nil)
                
                let toPresent = stb.instantiateViewController(withIdentifier: "newbar")
                self.present(toPresent, animated: true, completion: nil)
                
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action)->Void in
                
            })
            
            alertController.addAction(cancelButton)
            alertController.addAction(newButton)
            
        }
        
        
        self.present(alertController,animated: true, completion: nil)
        
        
        
    }
    
    func getTodayIndex()->Int{
        //get the current date from system
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var year = components.year!
        var month = components.month!
        var day = components.day!
        //[20,9,28,2017,4,4,0],
        let schoolDays = self.modelController.schoolDaysInfo
        
        var index = schoolDays.index(where:{$0[3]==year&&$0[1]==month&&$0[2]==day})
        
        let maxLookups = 40
        var counter = 0
        while index==nil && counter <= maxLookups{
            counter = counter + 1
            if day<31 {
                day = day + 1
                //print(day)
            } else if month<12 {
                day = 1
                month = month + 1
                //print(month)
            } else {
                day = 1
                month = 1
                year = year + 1
                //print(year)
            }
            index = schoolDays.index(where:{$0[3]==year&&$0[1]==month&&$0[2]==day})
        }
        if index == nil {
            index = 0
            
        }
        //print("below is get today index")
        //print(index as Any)
        let cycleDayToSave = schoolDays[index!][5]
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(cycleDayToSave, forKey: "today")
        return index!
    }
    
    @IBAction func todayPressed(_ sender: UIButton) {
        //get the current date from system
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var year = components.year!
        var month = components.month!
        var day = components.day!
        //[20,9,28,2017,4,4,0],
        let schoolDays = self.modelController.schoolDaysInfo
        
        var index = schoolDays.index(where:{$0[3]==year&&$0[1]==month&&$0[2]==day})
        
        let maxLookups = 40
        var counter = 0
        while index==nil && counter <= maxLookups{
            counter = counter + 1
            if day<31 {
                day = day + 1
                //print(day)
            } else if month<12 {
                day = 1
                month = month + 1
                //print(month)
            } else {
                day = 1
                month = 1
                year = year + 1
                //print(year)
            }
            index = schoolDays.index(where:{$0[3]==year&&$0[1]==month&&$0[2]==day})
        }
        //print(index as Any)
        if index == nil {
            index = 0
            print("**today pressed index nil")
        }
        let vcToPresent = self.modelController.viewControllerAtIndex(index!, storyboard: self.storyboard!)!
        let vcsToPresent = [vcToPresent]
        if !isPlayingAnimation {
            isPlayingAnimation = true
            if index! == currentPage {
                self.pageViewController!.setViewControllers(vcsToPresent, direction: .forward, animated: false, completion: {done in if done {
                    //print("done presenting!")
                    self.isPlayingAnimation = false
                    }})
            } else if index! < currentPage {
                
                
                self.pageViewController!.setViewControllers(vcsToPresent, direction: .reverse, animated: true, completion: {done in
                    if done {
                        //print("done presenting!")
                        self.isPlayingAnimation = false
                    }
                })
                self.currentPage = index!
                self.currentPageDay = schoolDays[index!][5]
                //self.d.text! = "No." + String(currentPage) + "Day " + String(currentPageDay)
            } else if index! > currentPage {
                
                self.pageViewController!.setViewControllers(vcsToPresent, direction: .forward, animated: true, completion: {done in
                    if done {
                        //print("done presenting!")
                        self.isPlayingAnimation = false
                    }})
                self.currentPage = index!
                self.currentPageDay = schoolDays[index!][5]
                //self.d.text! = "No." + String(currentPage) + "Day " + String(currentPageDay)
            }
        } else {
            resetTodayCount = resetTodayCount + 1
            if resetTodayCount > 2{
                isPlayingAnimation = false
            }
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        resetTodayCount = 0
        if self._modelController == nil {
            print("viewwillappearnil")
        }
        if let a = self._modelController?.readWholeCycle() {
            self._modelController?.wholeCycle = a
            //print("wholeupdated")
        }
        self._modelController?.updateFriends()
        /*
        print("***")
        print(currentPage)
        print("***")
        print(atPage as Any)
        print("***")
 */
        if let a = atPage {
            currentPage = a
            let currentViewController: DataViewController = self.modelController.viewControllerAtIndex(currentPage, storyboard: self.storyboard!)!
            let viewControllers = [currentViewController]
            
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        } else {
            currentPage = getTodayIndex()
            
            let currentViewController: DataViewController = self.modelController.viewControllerAtIndex(currentPage, storyboard: self.storyboard!)!
            let viewControllers = [currentViewController]
            
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
            //print("view will appear done page presented")
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        atPage = currentPage
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Checks if app has launced before
        if (UserDefaults.standard.bool(forKey: "launchedBefore")) {
            // This code will be run if the app has been launced before
            
        } else {
            // This code will be run if this is the first time the app is running
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            //Creates arrays stored in UserDefaults to be used by Planner function of the app
            UserDefaults.standard.set(["This is your digital planner!","Delete items by swiping them to the left", "Press add to add assignments"], forKey: "AssignmentNamesArray")
            UserDefaults.standard.set([Date(), Date(), Date()], forKey: "AssignmentDueDateArray")
            UserDefaults.standard.set([0, 0, 0], forKey: "AssignmentClassArray")
            UserDefaults.standard.set(["These are your notes! Add assignment notes here.", "These are your notes! Add assignment notes here.", "These are your notes! Add assignment notes here."], forKey: "AssignmentNotesArray")
            UserDefaults.standard.synchronize()
        }
        
        
        
        //self.view.UIColor
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        /*
         let color: UIColor = UIColor(red: (29/255.0), green: (54/255.0), blue: (95/255.0), alpha: 1.0)
         let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: self.view.bounds.width, height: 44))
         UIGraphicsBeginImageContext(rect.size)
         let context = UIGraphicsGetCurrentContext()!
         context.setFillColor(color.cgColor)
         context.fill(rect)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         topBar.image = image!
         */
        let optionsDict = [UIPageViewControllerOptionInterPageSpacingKey : 20]
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: optionsDict)
        
        
        
        self.pageViewController!.delegate = self
        let todayIndex = getTodayIndex()
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(todayIndex, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        currentPage = todayIndex
        currentPageDay = startingViewController.todayInfo[5]
        //self.d.text! = "No." + String(currentPage) + "Day " + String(currentPageDay)
        
        self.pageViewController!.dataSource = self.modelController
        
        self.addChildViewController(self.pageViewController!)
        
        self.view.addSubview(self.pageViewController!.view)
        
        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        
        var pageViewRect = CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.bounds.height-49)
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect
        
        self.pageViewController!.didMove(toParentViewController: self)
        if self._modelController == nil {
            print("model is nil")
        }
        self._modelController?.makeGetCall()
        self._modelController?.makeGetCall2()
        //print("makegetcalled/2")
        if let b = self._modelController?.ReadSchoolDays() {
            self._modelController?.schoolDaysInfo = b
            //print("did it")
        }
        if let c = self._modelController?.ReadSchoolDays2() {
            self._modelController?.schoolDaysInfo2 = c
            //print("did it 2")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
            
        }
        
        return _modelController!
    }
    
    var _modelController: ModelController? = nil
    
    // MARK: - UIPageViewController delegate methods
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers![0] as? DataViewController {
                self.currentPage = currentViewController.todayInfo[0]
                
                self.currentPageDay = currentViewController.todayInfo[5]
                //self.d.text! = "No." + String(currentPage) + "Day " + String(currentPageDay)
                
            }
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.pageViewController!.viewControllers![0]
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
            
            self.pageViewController!.isDoubleSided = false
            return .min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
        var viewControllers: [UIViewController]
        
        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        
        return .mid
    }
    
    
}

