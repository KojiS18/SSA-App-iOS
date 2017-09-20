

import UIKit


class DailyViewController: UIViewController {
    
    
    
    @IBOutlet weak var web: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.isUserInteractionEnabled = true
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myURL = URL(string: "https://sites.google.com/site/ssamobilehelper/schooldaysinfo/Daily%20Bulletin.png?attredirects=0&d=1")
        let myRequest = URLRequest(url: myURL!)
        web.loadRequest(myRequest)
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


