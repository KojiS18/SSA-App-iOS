//
//  LostAndFoundViewController.swift
//  SSA Student
//
//  Created by Nicholas Zana on 10/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

//Import Structure
//  [Sequence #(Int), Item Name(String), Owner Name(String), Contact Info(String), ImageLink(String), MoreInfo(String)]

import UIKit

//Defines lostAndFoundArray as a blank Array of Arrays of anything
var lostAndFoundArray: [Array<Any>] = []

class LostAndFoundViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Links tableView
    @IBOutlet weak var LFTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //This allows for dynamic tableviewcell heights for the lost and found items based on the height of the items themselves.
        LFTableView.rowHeight = UITableViewAutomaticDimension
        LFTableView.estimatedRowHeight = 140
        
        
        
        if UserDefaults.standard.bool(forKey: "HasBeenAnInitialDownload") {
            //This Code will run if this VC has been run before
            print("Checking for new .txt...")
            if let a = try? String(contentsOf: URL(string: "https://sites.google.com/site/ssamobilehelper/schooldaysinfo/lostandfound.txt")!) {
                print("Found, recieved, and set!")
                print(a)
                lostAndFoundArray = convertStringToArray(input: a)
                UserDefaults.standard.set(a, forKey: "LastLostAndFoundArray")
                UserDefaults.standard.synchronize()
            } else {
                print("Taking last saved value")
                lostAndFoundArray = UserDefaults.standard.array(forKey: "lostAndFoundArray") as! [Array<Any>]
            }
        } else {
            
            //This Code will run if this VC has never been run before
            
            if let a = try? String(contentsOf: URL(string: "https://sites.google.com/site/ssamobilehelper/schooldaysinfo/lostandfound.txt?attredirects=0&d=1")!) {
                print("Taking last saved value")
                UserDefaults.standard.set(a, forKey: "LastLostAndFoundArray")
                lostAndFoundArray = convertStringToArray(input: a)
                UserDefaults.standard.synchronize()
            } else {
                let alert = UIAlertController(title: "Cannot Get Lost and Found. Please Try Again Later.", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Return", style: UIAlertActionStyle.default, handler: {action in
                    self.goBack()
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
            //Saves in UserDefaults that this VC has run before
            UserDefaults.standard.set(true ,forKey: "HasBeenAnInitialDownload")
            UserDefaults.standard.synchronize()
            
        }
        
        LFTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Defines Table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Defines cell of type LostAndFoundItemTableViewCell to be of prototype cell in main.storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "LostAndFoundCell", for: indexPath) as! LostAndFoundItemTableViewCell
        
        //Imports the "item" that has been lost
        let item = lostAndFoundArray[indexPath.row]
        
        // Import Structure
        //  [Sequence #(Int), Item Name(String), Owner Name(String), Contact Info(String), ImageLink(String), MoreInfo(String)]
        
        //Sets ItemName label to string item name
        cell.ItemName.text = item[1] as? String
        //Sets Owner label to string owner name
        cell.Owner.text = item[2] as? String
        //Sets Conact (should be "Contact") to string contact info
        cell.Conact.text = item[3] as? String
        //Defines "ImageURL" as string ImageLink
        let ImageURL = URL(string: item[4] as! String)
        //Defines a URL if the image cannot be found
        let failedURL = URL(string: "https://media02.hongkiat.com/funny-creative-error-404/37-error-404-page.jpg")
        
        var asData:Data?
        
        if (try? Data(contentsOf: ImageURL!)) != nil {
            asData = try? Data(contentsOf: ImageURL!)
        } else {
            asData = try? Data(contentsOf: failedURL!)
        }
        //Sets UIImageView image to asData's contents
        cell.UIImageView.image = UIImage(data: asData!)
        cell.UIImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        //More info should be integrated with a "details" button in the future
        
        //Returns the now filled out cell
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Tells the tableView that it should have as many cells in the table as there are items in 2D Array lostAndFoundArray
        return lostAndFoundArray.count
    }
    
    func goBack() {
        print ("didPressGoBack")
    }
    
    func convertStringToArray(input: String) -> [Array<Any>] {
        let data = input.data(using: .utf8)
        var arrayforreturn:[Array<Any>]
        if let asarray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Array<Any>]{
            arrayforreturn = asarray!
        } else {
            arrayforreturn = [["FAILED"]]
        }
        
        return arrayforreturn
        
        
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
