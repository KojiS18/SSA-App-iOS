//
//  RequestAClubViewController.swift
//  SSA Student
//
//  Created by Nicholas Zana on 10/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class RequestAClubViewController: UIViewController {

    
    @IBOutlet weak var web: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://goo.gl/forms/bvE7gISi6KXyUPb22")
        let myRequest = URLRequest(url: myURL!)
        web.loadRequest(myRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
