//
//  DataViewController.swift
//  Prealpha
//
//  Created by Peter W on 5/4/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
    @IBOutlet var completeDateLabel: UILabel!
    @IBOutlet var pageIndexLabel: UILabel!
    @IBOutlet var cycleDayLabel: UILabel!
    
    var day: Int = 1
    var indexpage: Int = 0
    var completedate: String = ""
    var all: [[String]] = []
    var todayDayType: Int = 0
    

    @IBOutlet var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.delegate = self
        tv.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cycleDayLabel!.text = String(day)
        self.pageIndexLabel!.text = String(indexpage)
        self.completeDateLabel!.text = completedate
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch todayDayType {
            case 0: return 8//mon fri regular
            case 1: return 7//tue
            case 2: return 8//advisory
            case 3: return 8
            case 4: return 7
            default: return 7
        }
    }
    
    func p4title(ab: Bool) -> String {
        if ab{
            if all[day-1][3]=="Lunch"{
                return "Period 4a"
            }
            else if all[day-1][4]=="Lunch"{
                return "Period 4ab"
            }
        }
        else {
            if all[day-1][3]=="Lunch"{
                return "Period 4bc"
            }
            else if all[day-1][4]=="Lunch"{
                return "Period 4c"
            }
        }
        return "ERROR"
    }
    
    
    
    func p4subtitle(ab: Bool) -> String{
        if ab{
            if all[day-1][3]=="Lunch"{
                return "11:50-12:20"
            }
            else if all[day-1][4]=="Lunch"{
                return "11:50-12:40"
            }
        }
        else {
            if all[day-1][3]=="Lunch"{
                return "12:25-1:15"
            }
            else if all[day-1][4]=="Lunch"{
                return "12:45-1:15"
            }
        }
        return "ERROR"
    }
    
    func p4subtitleTue(ab: Bool) -> String{
        if ab{
            if all[day-1][3]=="Lunch"{
                return "11:55-12:25"
            }
            else if all[day-1][4]=="Lunch"{
                return "11:55-12:45"
            }
        }
        else {
            if all[day-1][3]=="Lunch"{
                return "12:30-1:20"
            }
            else if all[day-1][4]=="Lunch"{
                return "12:50-1:20"
            }
        }
        return "ERROR"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pcell", for: indexPath) as! PeriodCell
        
        switch todayDayType {
        case 0:
            switch indexPath.row{
            case 0: cell.whichperiod.text = "Period 1"
                    cell.wclass.text = all[day-1][0]
                    cell.periodtime.text = "8:15-9:05"
            case 1: cell.whichperiod.text = "Period 2"
                    cell.wclass.text = all[day-1][1]
                    cell.periodtime.text = "9:10-10:00"
            case 2: cell.whichperiod.text = "Assembly Period"
                    cell.wclass.text = "Community Assembly"
                    cell.periodtime.text = "10:05-10:30"
            case 3: cell.whichperiod.text = "Period 3"
                    cell.wclass.text = all[day-1][2]
                    cell.periodtime.text = "10:35-11:45"
            case 4: cell.whichperiod.text = p4title(ab: true)
                    cell.wclass.text = all[day-1][3]
                    cell.periodtime.text = p4subtitle(ab: true)
            case 5: cell.whichperiod.text = p4title(ab: false)
                    cell.wclass.text = all[day-1][4]
                    cell.periodtime.text = p4subtitle(ab: false)
            case 6: cell.whichperiod.text = "Period 5"
                    cell.wclass.text = all[day-1][5]
                    cell.periodtime.text = "1:20-2:10"
            case 7: cell.whichperiod.text = "Period 6"
                    cell.wclass.text = all[day-1][6]
                    cell.periodtime.text = "2:15-3:00"
            default: cell.whichperiod.text = "Period 0"
                     cell.wclass.text = "error"
                    cell.periodtime.text = "???"
            }
        case 1:
            switch indexPath.row{
            case 0: cell.whichperiod.text = "Period 1"
            cell.wclass.text = all[day-1][0]
            cell.periodtime.text = "8:50-9:40"
            case 1: cell.whichperiod.text = "Period 2"
            cell.wclass.text = all[day-1][1]
            cell.periodtime.text = "9:45-10:35"
            
            case 2: cell.whichperiod.text = "Period 3"
            cell.wclass.text = all[day-1][2]
            cell.periodtime.text = "10:40-11:50"
            case 3: cell.whichperiod.text = p4title(ab: true)
            cell.wclass.text = all[day-1][3]
            cell.periodtime.text = p4subtitleTue(ab: true)
            case 4: cell.whichperiod.text = p4title(ab: false)
            cell.wclass.text = all[day-1][4]
            cell.periodtime.text = p4subtitleTue(ab: false)
            case 5: cell.whichperiod.text = "Period 5"
            cell.wclass.text = all[day-1][5]
            cell.periodtime.text = "1:25-2:15"
            case 6: cell.whichperiod.text = "Period 6"
            cell.wclass.text = all[day-1][6]
            cell.periodtime.text = "2:20-3:05"
            default: cell.whichperiod.text = "Period 0"
            cell.wclass.text = "error"
            cell.periodtime.text = "???"
            }
        case 2:
            switch indexPath.row{
            case 0: cell.whichperiod.text = "Period 1"
            cell.wclass.text = all[day-1][0]
            cell.periodtime.text = "8:15-9:05"
            case 1: cell.whichperiod.text = "Period 2"
            cell.wclass.text = all[day-1][1]
            cell.periodtime.text = "9:10-10:00"
            case 2: cell.whichperiod.text = "Assembly Period"
            cell.wclass.text = "Advisory"
            cell.periodtime.text = "10:05-10:30"
            case 3: cell.whichperiod.text = "Period 3"
            cell.wclass.text = all[day-1][2]
            cell.periodtime.text = "10:35-11:45"
            case 4: cell.whichperiod.text = p4title(ab: true)
            cell.wclass.text = all[day-1][3]
            cell.periodtime.text = p4subtitle(ab: true)
            case 5: cell.whichperiod.text = p4title(ab: false)
            cell.wclass.text = all[day-1][4]
            cell.periodtime.text = p4subtitle(ab: false)
            case 6: cell.whichperiod.text = "Period 5"
            cell.wclass.text = all[day-1][5]
            cell.periodtime.text = "1:20-2:10"
            case 7: cell.whichperiod.text = "Period 6"
            cell.wclass.text = all[day-1][6]
            cell.periodtime.text = "2:15-3:00"
            default: cell.whichperiod.text = "Period 0"
            cell.wclass.text = "error"
            cell.periodtime.text = "???"
            }
        default: cell.whichperiod.text = "ERROR"
                 cell.wclass.text = "ERROR"
            
        }
        
        
        
        
        /*
        switch indexPath.row{
            
        case 0: cell.whichperiod.text = "Period 1"
                cell.wclass.text = all[day-1][0]
        case 1: cell.whichperiod.text = "Period 2"
            cell.wclass.text = all[day-1][1]
        case 2: cell.whichperiod.text = "Assembly"
            cell.wclass.text = "error"
        case 3: cell.whichperiod.text = "Period 3"
            cell.wclass.text = all[day-1][2]
        case 4: cell.whichperiod.text = "Period 4"
            cell.wclass.text = all[day-1][3]
        case 5: cell.whichperiod.text = "Period 5"
            cell.wclass.text = all[day-1][4]
        case 6: cell.whichperiod.text = "Period 6"
            cell.wclass.text = all[day-1][5]
        default: cell.whichperiod.text = "Period 0"
            cell.wclass.text = "error"
            
            
        }
         */
        
        return cell
        
        
        
    }
    
    
    
    
}

