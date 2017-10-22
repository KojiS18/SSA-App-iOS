import UIKit
import SafariServices
class MoreTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            let svc = SFSafariViewController(url: URL(string: "https://www.shadysideacademy.org/students/ms-ss-student-portal")!, entersReaderIfAvailable: true)
            
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    
    
}
