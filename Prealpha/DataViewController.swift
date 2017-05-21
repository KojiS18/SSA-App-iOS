//
//  DataViewController.swift
//  Prealpha
//
//  Created by Peter W on 5/4/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var dayn: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var day: Int = 1


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
        self.dataLabel!.text = dataObject
        self.dayn!.text = String(day)
        
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
        case 1: cell.whichperiod.text = "Period 2"
        case 2: cell.whichperiod.text = "Assembly"
        case 3: cell.whichperiod.text = "Period 3"
        case 4: cell.whichperiod.text = "Period 4"
        case 5: cell.whichperiod.text = "Period 5"
        case 6: cell.whichperiod.text = "Period 6"
        default: cell.whichperiod.text = "Period 0"
        }
        switch dayn.text!{
            case "1": cell.wclass.text = "english"
            case "2": cell.wclass.text = "english"
            case "3": cell.wclass.text = "english"
            case "4": cell.wclass.text = "english"
            default: cell.wclass.text = "english"
        }
        return cell
        
        
        
    }
    
    
}

