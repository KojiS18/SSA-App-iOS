//
//  MapViewController.swift
//  SSA Student
//
//  Created by pro admin on 9/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    var s: UIScrollView!
    var i: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let s = UIScrollView(frame: self.view.bounds)
        
        
        let i = UIImageView(image: #imageLiteral(resourceName: "SSA-map"))
        //i.contentMode = .scaleToFill
        s.contentSize = i.bounds.size
        s.autoresizingMask = UIViewAutoresizing.flexibleHeight
        s.addSubview(i)
        view.addSubview(s)
        
        
        
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
