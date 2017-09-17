

import UIKit


class TeacherViewController: UIViewController {

    
    @IBOutlet weak var web: UIWebView!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        web.goBack()
    }
    
    @IBAction func forward(_ sender: UIBarButtonItem) {
        web.goForward()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let myURL = URL(string: "https://www.shadysideacademy.org/students/ms-ss-student-portal")
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

