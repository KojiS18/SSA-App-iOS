
import UIKit
import WebKit

class NewsViewController: UIViewController {
    
    
    
    var web: WKWebView?
    

    
    @IBAction func back(_ sender: UIBarButtonItem) {
        web!.goBack()
    }
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        web!.goForward()
    }
    
    @IBAction func openSafari(_ sender: UIBarButtonItem) {
        UIApplication.shared.openURL(URL(string: "https://www.shadysideacademy.org/about/news")!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let minx = self.view.bounds.minX
        let miny = self.view.bounds.minY
        let maxx = self.view.bounds.maxX
        let maxy = self.view.bounds.maxY - 49
        let frame = CGRect(x: minx, y: miny, width: maxx-minx, height: maxy-miny)
        web = WKWebView(frame: frame)
        web!.isUserInteractionEnabled = true
        //web!.isUserInteractionEnabled = true
        self.view.addSubview(web!)
        self.view.sendSubview(toBack: web!)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myURL = URL(string: "https://www.shadysideacademy.org/about/news")
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


