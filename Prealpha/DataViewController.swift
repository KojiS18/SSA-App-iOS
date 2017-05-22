//
//  DataViewController.swift
//  Prealpha
//
//  Created by Peter W on 5/4/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
    @IBOutlet var date: UILabel!
    @IBOutlet var ipage: UILabel!
    @IBOutlet var dayn: UILabel!
    
    var day: Int = 1
    var indexpage: Int = 0
    var completedate: String = ""
    var all: [[String]] = []

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
        
        self.dayn!.text = String(day)
        self.ipage!.text = String(indexpage)
        self.date!.text = completedate
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pcell", for: indexPath) as! PeriodCell
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
        
        return cell
        
        
        
    }
    
    
}

