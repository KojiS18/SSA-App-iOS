//
//  FeedbackViewController.swift
//  SSA Student
//
//  Created by pro admin on 9/21/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import WebKit

class FeedbackViewController: UIViewController {

    var web: WKWebView!
    
    
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        web.goBack()
    }
    
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        web.goForward()
    }
    
    
    /*
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        let minx = self.view.bounds.minX
        let miny = self.view.bounds.minY
        let maxx = self.view.bounds.maxX
        let maxy = self.view.bounds.maxY - 49
        let frame = CGRect(x: minx, y: miny, width: maxx-minx, height: maxy-miny)
        web = WKWebView(frame: frame)
        //self.web.uiDelegate = self
        web!.isUserInteractionEnabled = true
        //web!.customUserAgent
        
        self.view.addSubview(web!)
        self.view.sendSubview(toBack: web!)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myURL = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSetnf3trosKponyH8q4fMbgaH2COwR7rbPNypPe9bSW1xq60Q/viewform?usp=sf_link")
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    

}
