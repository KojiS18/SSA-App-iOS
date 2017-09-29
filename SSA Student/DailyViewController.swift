

import UIKit
import WebKit

class DailyViewController: UIViewController {
    
    
    var web: WKWebView?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let minx = self.view.bounds.minX
        let miny = self.view.bounds.minY
        let maxx = self.view.bounds.maxX
        let maxy = self.view.bounds.maxY - 49
        let frame = CGRect(x: minx, y: miny, width: maxx-minx, height: maxy-miny)
        web = WKWebView(frame: frame)
       
        web!.isUserInteractionEnabled = true
        self.view.addSubview(web!)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myURL = URL(string: "https://sites.google.com/site/ssamobilehelper/schooldaysinfo/Daily%20Bulletin.pdf?attredirects=0&d=1")
        let myRequest = URLRequest(url: myURL!)
        web!.load(myRequest)
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


