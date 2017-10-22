//
//  DramaTicketsViewController.swift
//  SSA Student
//
//  Created by Nicholas Zana on 10/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import WebKit

class DramaTicketsViewController: UIViewController, WKUIDelegate {
    var web: WKWebView!
    
    
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        web.goBack()
    }
    
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        web.goForward()
    }
    
    @IBAction func openSafari(_ sender: UIBarButtonItem) {
        UIApplication.shared.openURL(URL(string: "https://red.vendini.com/ticket-software.html?t=tix&e=24604580275ef0bc43ffacc39d7a7812")!)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let minx = self.view.bounds.minX
        let miny = self.view.bounds.minY
        let maxx = self.view.bounds.maxX
        let maxy = self.view.bounds.maxY - 49
        let frame = CGRect(x: minx, y: miny, width: maxx-minx, height: maxy-miny)
        web = WKWebView(frame: frame)
        self.web.uiDelegate = self
        web!.isUserInteractionEnabled = true
        
        self.view.addSubview(web!)
        self.view.sendSubview(toBack: web!)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myURL = URL(string: "https://red.vendini.com/ticket-software.html?t=tix&e=24604580275ef0bc43ffacc39d7a7812")
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
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
