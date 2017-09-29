//
//  DataViewController.swift
//  Alpha
//
//  Created by admin on 7/14/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    //var currentPage: Int = 0
    //@IBOutlet weak var dataLabel: UILabel!
    //var dataObject: String = ""
    var wholeCycle: [[String]] = []
    var todayInfo: [Int] = []
    var specialDayTypeInfo: [String] = []
    
    
    var friendsNames: [String] = []
    var friendsFrees: [[Bool]] = []
    //@IBOutlet weak var periods: UIStackView!
    let dic: [Int: String] = [1:" - Mon, ",2:" - 8:50 Start Time - Tue, ", 3:" - Wed, ",4:" - Thu, ",5:" - Fri, ", 6:" - Sat, ", 7:" - Sun, "]
    
    //@IBOutlet weak var dd: UILabel!
    //@IBOutlet var periods: UITableView!
    
    @IBOutlet weak var newButton: UIButton!
    
    
    
    @IBOutlet var pageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if wholeCycle.count == 10{
            self.newButton.isHidden = true
        }
        //let backgroundGradient = CAGradientLayer()
        //backgroundGradient.frame = self.view.bounds
        //let topColor = UIColor(red: 255.0/255.0, green: 246.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
        //let botColor = UIColor(red: 215.0/255.0, green: 194.0/255.0, blue: 138.0/255.0, alpha: 1.0).cgColor
        //backgroundGradient.colors = [topColor, botColor]
        //self.view.layer.addSublayer(backgroundGradient)
        
        if self.view.bounds.width == 320 {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named:"SSA_BG1_IOS (640x1136)")!)
            print(1)
            print(view.bounds.height)
            
        } else if self.view.bounds.width == 375 {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named:"SSA_BG1_IOS (750x1334)")!)
            print(2)
            print(view.bounds.height)
        } else {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named:"SSA_BG1_IOs (1242x2208)")!)
            print(3)
            print(view.bounds.width)
            print(view.bounds.height)
        }
        
        let containerView1 = UIStackView()
        containerView1.alignment = .fill
        containerView1.axis = .vertical
        containerView1.distribution = .fillEqually
        //containerView1.spacing = 25
        self.view.addSubview(containerView1)
        containerView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: containerView1, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 60.0).isActive = true
        NSLayoutConstraint(item: containerView1, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -45.0).isActive = true
        NSLayoutConstraint(item: containerView1, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 25.0).isActive = true
        NSLayoutConstraint(item: containerView1, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -50.0).isActive = true
        var rows = 11
        /*
        switch todayInfo[0]%10 {
        case 0: rows = 5
        case 1: rows = 6
        case 2: rows = 7
        case 3: rows = 8
        case 4: rows = 9
        case 5: rows = 10
        case 6: rows = 11
        case 7: rows = 12
        case 8: rows = 13
        case 9: rows = 14
        default: print("imp")
            
        }*/
        if todayInfo[6]==0{
            switch todayInfo[4]{
            case 1: rows = 9
            case 2: rows = 8
            case 3,4,5: rows = 9
                
            default: rows = 8
            }
        }
        else{
            rows = specialDayTypeInfo.count/3
        }
        if rows != 0 {
            
        
        for x in 0...rows-1{
            let v = UIView()
            //v.layer.borderWidth = 1
            
            //v.layer.borderColor = UIColor.black.cgColor
            if x != rows-1{
                let gradientLayer = CAGradientLayer()
                let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width-75, height: 1)
                let line = UIView(frame: frame)
                gradientLayer.frame = frame
                
                gradientLayer.colors = [UIColor.gray.withAlphaComponent(0.3).cgColor, UIColor.gray.withAlphaComponent(1.0).cgColor, UIColor.gray.withAlphaComponent(0.8).cgColor, UIColor.gray.withAlphaComponent(0.3).cgColor,]
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.locations = [0.0, 0.2, 0.6, 1.0]
                
                
                line.layer.addSublayer(gradientLayer)
                v.addSubview(line)
                line.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: v, attribute: .bottom, multiplier: 1, constant: -0.5).isActive = true
                NSLayoutConstraint(item: line, attribute: .left, relatedBy: .equal, toItem: v, attribute: .left, multiplier: 1, constant: 25).isActive = true
            }
            var periodN = ""
            var classN = ""
            var timeN = ""
            var freeWith = ""
            if todayInfo[6]==0{
                let tuple = CreateRegular(row: x, cycle: todayInfo[5], week: todayInfo[4])
                periodN = tuple.which
                classN = tuple.what
                freeWith = tuple.with
                timeN = tuple.when
                
            } else {
                periodN = specialDayTypeInfo[x]
                let w = CreateIrregular(code: specialDayTypeInfo[x + 2 * (specialDayTypeInfo.count / 3)], cycle: todayInfo[5])
                classN = w.0
                if w.1 != nil {
                    freeWith = w.1!
                }
                
                timeN = specialDayTypeInfo[x + specialDayTypeInfo.count / 3]
            }
            
            let whichPeriod = UILabel()
            let t = NSMutableAttributedString(
                string: periodN,
                attributes: [NSFontAttributeName:UIFont(
                    name: "HelveticaNeue-Medium",
                    size: 18.0)!])
            whichPeriod.attributedText = t
            v.addSubview(whichPeriod)
            whichPeriod.translatesAutoresizingMaskIntoConstraints = false
            
            
            let whatTime = UILabel()
            let t2 = NSMutableAttributedString(
                string: timeN,
                attributes: [NSFontAttributeName:UIFont(
                    name: "HelveticaNeue-Italic",
                    size: 14.0)!])
            whatTime.attributedText = t2
            v.addSubview(whatTime)
            whatTime.translatesAutoresizingMaskIntoConstraints = false
            
            let whatClass = UILabel()
            whatClass.adjustsFontSizeToFitWidth = true
            var className = NSMutableAttributedString(
                string: classN,
                attributes: [NSFontAttributeName:UIFont(
                    name: "Georgia",
                    size: 20.0)!])
            if freeWith != "" {
                whatClass.adjustsFontSizeToFitWidth = false
                whatClass.numberOfLines = 3
                freeWith = "\nwith: " + freeWith
                let f = NSMutableAttributedString(
                    string: freeWith,
                    attributes: [NSFontAttributeName:UIFont(
                        name: "Georgia",
                        size: 10.0)!])
                className.append(f)
            }
            whatClass.attributedText = className
            v.addSubview(whatClass)
            whatClass.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.5).isActive = true
            whatClass.translatesAutoresizingMaskIntoConstraints = false
            /*
            let names = UILabel()
            let namesString = NSMutableAttributedString(
                string: "AB BC CD DE EF FG GH HI IJ JK KL LM",
                attributes: [NSFontAttributeName:UIFont(
                    name: "Georgia",
                    size: 10.0)!])
            names.attributedText = namesString
            v.addSubview(names)
            names.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint(item: names, attribute: .left, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.6, constant: 0).isActive = true
            NSLayoutConstraint(item: names, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 1.4, constant: 0).isActive = true
            */
            var cons: CGFloat = 0
            if self.view.bounds.width < 375 {
                cons = 20.0
            }
            NSLayoutConstraint(item: whatClass, attribute: .left, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.8, constant: cons).isActive = true
            NSLayoutConstraint(item: whatClass, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
            
            NSLayoutConstraint(item: whichPeriod, attribute: .left, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.20, constant: 0).isActive = true
            NSLayoutConstraint(item: whichPeriod, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 0.8, constant: 0).isActive = true
            NSLayoutConstraint(item: whatTime, attribute: .left, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.20, constant: 0).isActive = true
            NSLayoutConstraint(item: whatTime, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 1.5, constant: 0).isActive = true
            
            
            //v.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            containerView1.addArrangedSubview(v)
            
        }
        }
        
        
        
        /*
         
         let containerView1 = UIStackView()
         containerView1.alignment = .fill
         containerView1.axis = .vertical
         containerView1.distribution = .fillEqually
         containerView1.spacing = 5
         
         self.view.addSubview(containerView1)
         containerView1.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint(item: containerView1, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 60.0).isActive = true
         NSLayoutConstraint(item: containerView1, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -45.0).isActive = true
         NSLayoutConstraint(item: containerView1, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 25.0).isActive = true
         NSLayoutConstraint(item: containerView1, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -50.0).isActive = true
         var rows = 1
         switch todayInfo[0]%10 {
         case 0: rows = 5
         case 1: rows = 6
         case 2: rows = 7
         case 3: rows = 8
         case 4: rows = 9
         case 5: rows = 10
         case 6: rows = 11
         case 7: rows = 12
         case 8: rows = 13
         case 9: rows = 14
         default: print("imp")
         
         }
         if todayInfo[6]==0{
         switch todayInfo[4]{
         case 1: rows = 9
         case 2: rows = 8
         case 3,4,5: rows = 9
         
         default: rows = 8
         }
         }
         else{
         rows = specialDayTypeInfo.count/3
         }
         
         //et green = UIColor(red: 153, green: 184, blue: 152, alpha: 1)
         //let pink = UIColor(red: 153, green: 184, blue: 152, alpha: 1)
         for x in 0...rows-1{
         let v = UIView()
         v.layer.cornerRadius = 15
         
         
         
         var periodN = ""
         var classN = ""
         var timeN = ""
         if todayInfo[6]==0{
         let tuple = CreateRegular(row: x, cycle: todayInfo[5], week: todayInfo[4])
         periodN = tuple.which
         classN = tuple.what
         timeN = tuple.when
         } else {
         periodN = specialDayTypeInfo[x]
         classN = CreateIrregular(code: specialDayTypeInfo[x + 2 * (specialDayTypeInfo.count / 3)], cycle: todayInfo[5])
         timeN = specialDayTypeInfo[x + specialDayTypeInfo.count / 3]
         }
         var y = 11
         for x in 0...7 {
         if classN == wholeCycle[x][4] {
         y = x
         }
         }
         //v.layer.borderWidth = 5
         switch y {
         
         
         case 0: v.backgroundColor = UIColor.brown.withAlphaComponent(0.4)
         case 1: v.backgroundColor = UIColor.green.withAlphaComponent(0.4)
         case 2: v.backgroundColor = UIColor.yellow.withAlphaComponent(0.4)
         case 3: v.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
         case 4: v.backgroundColor = UIColor.purple.withAlphaComponent(0.4)
         case 5: v.backgroundColor = UIColor.orange.withAlphaComponent(0.4)
         case 6: v.backgroundColor = UIColor.magenta.withAlphaComponent(0.4)
         case 7: v.backgroundColor = UIColor.cyan.withAlphaComponent(0.4)
         default: v.backgroundColor = UIColor.red.withAlphaComponent(0.4)
         /*
         case 0: v.layer.borderColor = UIColor.brown.withAlphaComponent(0.5).cgColor
         case 1: v.layer.borderColor = UIColor.green.withAlphaComponent(0.5).cgColor
         case 2: v.layer.borderColor = UIColor.yellow.withAlphaComponent(0.5).cgColor
         case 3: v.layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
         case 4: v.layer.borderColor = UIColor.purple.withAlphaComponent(0.5).cgColor
         case 5: v.layer.borderColor = UIColor.orange.withAlphaComponent(0.5).cgColor
         case 6: v.layer.borderColor = UIColor.magenta.withAlphaComponent(0.5).cgColor
         case 7: v.layer.borderColor = UIColor.cyan.withAlphaComponent(0.5).cgColor
         default: v.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
         */
         }
         
         let whichPeriod = UILabel()
         whichPeriod.adjustsFontSizeToFitWidth = true
         let periodName = NSMutableAttributedString(
         string: periodN,
         attributes: [NSFontAttributeName:UIFont(
         name: "Georgia",
         size: 17.0)!])
         whichPeriod.attributedText = periodName
         v.addSubview(whichPeriod)
         whichPeriod.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.17).isActive = true
         whichPeriod.translatesAutoresizingMaskIntoConstraints = false
         
         
         let whatTime = UILabel()
         let t2 = NSMutableAttributedString(
         string: timeN,
         attributes: [NSFontAttributeName:UIFont(
         name: "HelveticaNeue-Italic",
         size: 14.0)!])
         whatTime.attributedText = t2
         v.addSubview(whatTime)
         whatTime.translatesAutoresizingMaskIntoConstraints = false
         
         let whatClass = UILabel()
         whatClass.adjustsFontSizeToFitWidth = true
         let className = NSMutableAttributedString(
         string: classN,
         attributes: [NSFontAttributeName:UIFont(
         name: "Georgia",
         size: 23.0)!])
         whatClass.attributedText = className
         v.addSubview(whatClass)
         whatClass.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.5).isActive = true
         whatClass.translatesAutoresizingMaskIntoConstraints = false
         
         let whatInitials = UILabel()
         let namesString = NSMutableAttributedString(
         string: "AB BC CD DE EF FG GH HI IJ JK KL LM",
         attributes: [NSFontAttributeName:UIFont(
         name: "Georgia",
         size: 10.0)!])
         whatInitials.attributedText = namesString
         v.addSubview(whatInitials)
         whatInitials.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint(item: whatInitials, attribute: .left, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.6, constant: 0).isActive = true
         NSLayoutConstraint(item: whatInitials, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 1.4, constant: 0).isActive = true
         
         NSLayoutConstraint(item: whatClass, attribute: .left, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.6, constant: 0).isActive = true
         NSLayoutConstraint(item: whatClass, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 0.80, constant: 0).isActive = true
         
         NSLayoutConstraint(item: whichPeriod, attribute: .centerX, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.35, constant: 0).isActive = true
         NSLayoutConstraint(item: whichPeriod, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 0.7, constant: 0).isActive = true
         
         NSLayoutConstraint(item: whatTime, attribute: .centerX, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 0.35, constant: 0).isActive = true
         NSLayoutConstraint(item: whatTime, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 1.5, constant: 0).isActive = true
         
         
         containerView1.addArrangedSubview(v)
         
         }
         
         
         */
        
        pageLabel.superview?.bringSubview(toFront: pageLabel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataLabel!.text = dataObject
        //[0,8,29,2017,2,0,1]
        self.pageLabel!.text = "Day \(todayInfo[5])\(dic[todayInfo[4]]!)\(todayInfo[1])/\(todayInfo[2])"
        //"\(todayInfo[1])/\(todayInfo[2])/\(todayInfo[3]), Weekday \(todayInfo[4]), Day \(todayInfo[5])"
        //self.dd!.text = String(todayInfo[0])
    }
    /*
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     if todayInfo[6]==0{
     switch todayInfo[4]{
     case 1: return 9
     case 2: return 8
     case 3: return 9
     case 4: return 9
     case 5: return 9
     default: return 8
     }
     }
     else{
     return specialDayTypeInfo.count/3
     }
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "periodCell", for: indexPath) as! PeriodCell
     cell.backgroundColor = UIColor.clear
     cell.selectionStyle = .none
     if todayInfo[6]==0{
     let tuple = CreateRegular(row: indexPath.row, cycle: todayInfo[5], week: todayInfo[4])
     cell.whichPeriod.text = tuple.which
     cell.whatClass.text = tuple.what
     cell.duration.text = tuple.when
     } else {
     cell.whichPeriod.text = specialDayTypeInfo[indexPath.row]
     cell.whatClass.text = CreateIrregular(code: specialDayTypeInfo[indexPath.row + 2 * (specialDayTypeInfo.count / 3)], cycle: todayInfo[5])
     cell.duration.text = specialDayTypeInfo[indexPath.row + specialDayTypeInfo.count / 3]
     }
     return cell
     }
     */
    let monday = ["Period 1","Period 2","Assembly","Period 3","Period 4a","Period 4b","Period 4c","Period 5","Period 6","8:15-9:05","9:10-10:00","10:05-10:30","10:35-11:45","11:50-12:20","12:25-12:40","12:45-1:15","1:20-2:10","2:15-3:00",]
    let tuesday = ["Period 1","Period 2","Period 3","Period 4a","Period 4b","Period 4c","Period 5","Period 6","8:50-9:40","9:45-10:35","10:40-11:50","11:55-12:25","12:30-12:45","12:50-1:20","1:25-2:15","2:20-3:05"]
    let wednesday = ["Period 1","Period 2","Assembly","Period 3","Period 4a","Period 4b","Period 4c","Period 5","Period 6","8:15-9:05","9:10-10:00","10:05-10:30","10:35-11:45","11:50-12:20","12:25-12:40","12:45-1:15","1:20-2:10","2:15-3:00"]
    let thursday = ["Period 1","Period 2","Assembly","Period 3","Period 4a","Period 4b","Period 4c","Period 5","Period 6","8:15-9:05","9:10-10:00","10:05-10:30","10:35-11:45","11:50-12:20","12:25-12:40","12:45-1:15","1:20-2:10","2:15-3:00"]
    let friday = ["Period 1","Period 2","Assembly","Period 3","Period 4a","Period 4b","Period 4c","Period 5","Period 6","8:15-9:05","9:10-10:00","10:05-10:30","10:35-11:45","11:50-12:20","12:25-12:40","12:45-1:15","1:20-2:10","2:15-3:00"]
    func getFreeFriends(cycle: Int, row: Int)->String{
        var res = ""
        let pos = cycle * 8 + row
        if friendsFrees.count > 0 {
            for x in 0...friendsFrees.count-1 {
                if friendsFrees[x][pos] {
                    /*
                    var wholeNameParts = friendsNames[x].split(separator: " ")
                    if wholeNameParts.count > 1 && wholeNameParts[1].characters.count > 0 {
                        let first = String(wholeNameParts[0])
                        let last = String(wholeNameParts[1])
                        res.append(first + String(last[last.startIndex]).uppercased() + ", ")
                    } else {
                        let first = String(wholeNameParts[0])
                        res.append(first + ", ")
                    }
 */
                    let first = String(friendsNames[x])!
                    res.append(first + ", ")
                    
                }
            }
            print("this is res \(res)")
            if res.characters.count > 2 {
                print("removing")
                let stringindex = res.index(res.endIndex, offsetBy: -2)
                print(stringindex)
                res = res.substring(to: stringindex)
                print(res)
            }
 
            
            
            
        }
        return res
    }
    func CreateRegular(row: Int, cycle: Int, week: Int)->(which: String, when: String, what: String, with: String){
        var res: (which: String, when: String, what: String, with: String) = ("","","","")
        switch week{
        case 1:
            res.which = monday[row]
            res.when = monday[row+9]
            switch row{
            case 0,1:
                res.what = wholeCycle[cycle-1][row]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row)
                }
            case 2:
                res.what = "Community Assembly"
            case 3,4,5,6,7,8:
                res.what = wholeCycle[cycle-1][row-1]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row-1)
                }
            default:
                res.what = "error"
            }
        case 2:
            res.which = tuesday[row]
            res.when = tuesday[row+8]
            res.what = wholeCycle[cycle-1][row]
            if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                res.with = getFreeFriends(cycle: cycle-1, row: row)
            }
        case 3:
            res.which = wednesday[row]
            res.when = wednesday[row+9]
            switch row{
            case 0,1:
                res.what = wholeCycle[cycle-1][row]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row)
                }
            case 2:
                res.what = "Advisory"
            case 3,4,5,6,7,8:
                res.what = wholeCycle[cycle-1][row-1]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row-1)
                }
            default:
                res.what = "error"
            }
        case 4:
            res.which = thursday[row]
            res.when = thursday[row+9]
            switch row{
            case 0,1:
                res.what = wholeCycle[cycle-1][row]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row)
                }
            case 2:
                res.what = "Class Meeting"
            case 3,4,5,6,7,8:
                res.what = wholeCycle[cycle-1][row-1]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row-1)
                }
            default:
                res.what = "error"
            }
        case 5:
            res.which = friday[row]
            res.when = friday[row+9]
            switch row{
            case 0,1:
                res.what = wholeCycle[cycle-1][row]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row)
                }
            case 2:
                res.what = "Community Assembly"
            case 3,4,5,6,7,8:
                res.what = wholeCycle[cycle-1][row-1]
                if res.what=="Free" || res.what=="Lunch" || res.what=="free" || res.what==" free" || res.what=="free " || res.what=="Free " || res.what==" Free"{
                    res.with = getFreeFriends(cycle: cycle-1, row: row-1)
                }
            default:
                res.what = "error"
            }
        default:
            print("error")
        }
        return res
        
        
    }
    
    func CreateIrregular(code: String, cycle: Int)->(String,String?){
        let codeArray = code.components(separatedBy: "-")
        if codeArray.count == 2{
            var day = 10
            var period = 10
            if codeArray[0]=="r" || codeArray[0]=="R" || codeArray[0]==" r" || codeArray[0]=="r "{
                day = todayInfo[5]
                if day == 0 {
                    return (code,nil)
                }
            } else {
                switch codeArray[0]{
                case "1","2","3","4","5","6","7","8": day = Int(codeArray[0])!
                    
                case "1 "," 1"," 1 ","  1","  1 ": day = 1
                case "2 "," 2"," 2 ","  2","  2 ": day = 2
                case "3 "," 3"," 3 ","  3","  3 ": day = 3
                case "4 "," 4"," 4 ","  4","  4 ": day = 4
                case "5 "," 5"," 5 ","  5","  5 ": day = 5
                case "6 "," 6"," 6 ","  6","  6 ": day = 6
                case "7 "," 7"," 7 ","  7","  7 ": day = 7
                case "8 "," 8"," 8 ","  8","  8 ": day = 8
                default: break
                }
            }
            switch codeArray[1]{
            case "1","1 "," 1","  1","  1 "," 1 ": period = 1
            case "2","2 "," 2","  2","  2 "," 2 ": period = 2
            case "3","3 "," 3","  3","  3 "," 3 ": period = 3
            case "4a","4a "," 4a","  4a","  4a "," 4a ": period = 4
            case "4A","4A "," 4A","  4A","  4A "," 4A ": period = 4
            case "4b","4b "," 4b","  4b","  4b "," 4b ": period = 5
            case "4B","4B "," 4B","  4B","  4B "," 4B ": period = 5
            case "4c","4c "," 4c","  4c","  4c "," 4c ": period = 6
            case "4C","4C "," 4C","  4C","  4C "," 4C ": period = 6
            case "5","5 "," 5","  5","  5 "," 5 ": period = 7
            case "6","6 "," 6","  6","  6 "," 6 ": period = 8
            default: break
            }
            if day != 10 && period != 10 {
                //print("\(day)  \(period)")
                let res = self.wholeCycle[day-1][period-1]
                if res=="Free" || res=="Lunch" || res=="free" || res==" free" || res=="free " || res=="Free " || res==" Free"{
                    return (res,getFreeFriends(cycle: day-1, row: period-1))
                }
            } else {
                return (code,nil)
            }
            
        } else {
            return (code,nil)
        }
        return (code,nil)
    }
    func generateWholeCycle(using: [String]) -> [[String]]{
        //guard using.count == 24
        let p4Name = [using[0],using[3],using[6],using[9],using[12],using[15],using[18],using[21],]
        var wholeCycle: [[String]] = []
        wholeCycle.append([p4Name[4],p4Name[7],p4Name[2],p4Name[0],p4Name[3],p4Name[6]])
        wholeCycle.append([p4Name[5],p4Name[0],p4Name[3],p4Name[1],p4Name[4],p4Name[7]])
        wholeCycle.append([p4Name[6],p4Name[1],p4Name[4],p4Name[2],p4Name[5],p4Name[0]])
        wholeCycle.append([p4Name[7],p4Name[2],p4Name[5],p4Name[3],p4Name[6],p4Name[1]])
        wholeCycle.append([p4Name[0],p4Name[3],p4Name[6],p4Name[4],p4Name[7],p4Name[2]])
        wholeCycle.append([p4Name[1],p4Name[4],p4Name[7],p4Name[5],p4Name[0],p4Name[3]])
        wholeCycle.append([p4Name[2],p4Name[5],p4Name[0],p4Name[6],p4Name[1],p4Name[4]])
        wholeCycle.append([p4Name[3],p4Name[6],p4Name[1],p4Name[7],p4Name[2],p4Name[5]])
        for i in 0...7{
            switch using[i * 3 + 1]{
            case "AB":
                wholeCycle[i].insert("Lunch", at: 4)
                wholeCycle[i].insert(wholeCycle[i][3], at: 3)
            case "BC":
                wholeCycle[i].insert("Lunch", at: 3)
                wholeCycle[i].insert(wholeCycle[i][4], at: 4)
            case "Free":
                wholeCycle[i].insert("Free", at: 3)
                wholeCycle[i].insert(wholeCycle[i][4], at: 4)
            default:
                wholeCycle[i].insert("error", at: 3)
                wholeCycle[i].insert(wholeCycle[i][4], at: 4)
            }
            if using[i * 3 + 2] == "Science" {
                switch i{
                case 0:
                    wholeCycle[4][2] = wholeCycle[0][4]
                    wholeCycle[0][6] = wholeCycle[0][4]
                case 1:
                    wholeCycle[5][2] = wholeCycle[1][4]
                    wholeCycle[1][6] = wholeCycle[1][4]
                case 2:
                    wholeCycle[6][2] = wholeCycle[2][4]
                    wholeCycle[2][6] = wholeCycle[2][4]
                case 3:
                    wholeCycle[7][2] = wholeCycle[3][4]
                    wholeCycle[3][6] = wholeCycle[3][4]
                case 4:
                    wholeCycle[0][2] = wholeCycle[4][4]
                    wholeCycle[4][6] = wholeCycle[4][4]
                case 5:
                    wholeCycle[1][2] = wholeCycle[5][4]
                    wholeCycle[5][6] = wholeCycle[5][4]
                case 6:
                    wholeCycle[2][2] = wholeCycle[6][4]
                    wholeCycle[6][6] = wholeCycle[6][4]
                case 7:
                    wholeCycle[3][2] = wholeCycle[7][4]
                    wholeCycle[7][6] = wholeCycle[7][4]
                default:
                    break
                }
            }
        }
        return wholeCycle
        
    }
    
    
}

