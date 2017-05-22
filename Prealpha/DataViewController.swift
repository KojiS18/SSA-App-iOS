//
//  DataViewController.swift
//  Prealpha
//
//  Created by Peter W on 5/4/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var d = [[8, 29, 17, 2, 0, 0], [8, 30, 17, 3, 1, 1], [8, 31, 17, 4, 2, 2], [9, 1, 17, 5, 3, 3], [9, 4, 17, 1, 4, 4], [9, 5, 17, 2, 5, 5], [9, 6, 17, 3, 6, 6], [9, 7, 17, 4, 7, 7], [9, 8, 17, 5, 8, 8], [9, 11, 17, 1, 1, 9], [9, 12, 17, 2, 2, 10], [9, 13, 17, 3, 3, 11], [9, 14, 17, 4, 4, 12], [9, 15, 17, 5, 5, 13], [9, 18, 17, 1, 6, 14], [9, 19, 17, 2, 7, 15], [9, 20, 17, 3, 8, 16], [9, 21, 17, 4, 1, 17], [9, 22, 17, 5, 2, 18], [9, 25, 17, 1, 3, 19], [9, 26, 17, 2, 4, 20], [9, 27, 17, 3, 5, 21], [9, 28, 17, 4, 6, 22], [9, 29, 17, 5, 7, 23], [10, 2, 17, 1, 8, 24], [10, 3, 17, 2, 1, 25], [10, 4, 17, 3, 2, 26], [10, 5, 17, 4, 3, 27], [10, 6, 17, 5, 4, 28], [10, 9, 17, 1, 5, 29], [10, 10, 17, 2, 6, 30], [10, 11, 17, 3, 7, 31], [10, 12, 17, 4, 8, 32], [10, 13, 17, 5, 1, 33], [10, 16, 17, 1, 2, 34], [10, 17, 17, 2, 3, 35], [10, 18, 17, 3, 4, 36], [10, 19, 17, 4, 5, 37], [10, 20, 17, 5, 6, 38], [10, 23, 17, 1, 7, 39], [10, 24, 17, 2, 8, 40], [10, 25, 17, 3, 1, 41], [10, 26, 17, 4, 2, 42], [10, 27, 17, 5, 3, 43], [10, 30, 17, 1, 4, 44], [10, 31, 17, 2, 5, 45]]

    
    @IBOutlet var ipage: UILabel!
    @IBOutlet var dayn: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    var day: Int = 1
    var indexpage: Int = 0


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
        self.ipage!.text = String(indexpage)
        
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

