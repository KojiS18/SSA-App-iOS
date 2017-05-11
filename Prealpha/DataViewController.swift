//
//  DataViewController.swift
//  Prealpha
//
//  Created by Peter W on 5/4/17.
//  Copyright © 2017 Peter W. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    


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
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodCell", for: indexPath)
        
        cell.textLabel?.text = "Period"
        
        return cell
    }
    
    
}

