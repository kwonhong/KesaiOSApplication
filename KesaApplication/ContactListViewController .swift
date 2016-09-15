//
//  ContactListViewController.swift
//  KesaApplication
//
//  Created by Jiwoo Lim on 2016. 7. 19..
//  Copyright © 2016년 kesa. All rights reserved.
//


import UIKit
import Firebase
import LiquidFloatingActionButton
/*
public class CustomCell : LiquidFloatingCell {
    var name: String = "sample"
    
    init(icon: UIImage, name: String) {
        self.name = name
        super.init(icon: icon)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setupView(view: UIView) {
        super.setupView(view)
        let label = UILabel()
        label.text = name
        label.textColor = UIColor.blackColor()
        label.font = UIFont(name: "Helvetica-Neue", size: 12)
        label.constraint { make in
            make.left.equalTo(self).offset(-80)
            make.width.equalTo(75)
            make.top.height.equalTo(self)
        }

        addSubview(label)
    }
}*/



class ContactListViewController : UITableViewController {
    
    let ref = FIRDatabase.database().reference()
    var userID = NSString()
    var postDict = NSDictionary()
    var myInfo = NSMutableDictionary()
    var rowCount = NSInteger()
    var keys = NSArray()
    var profileInfo = NSDictionary()
    var refreshCtrl = UIRefreshControl()
    var names = NSMutableArray()
    var years = NSMutableArray()
    let contactList = NSMutableDictionary()
    var sortedContactList = NSMutableDictionary()
    
    var cells = [LiquidFloatingCell]() //datasource
    var floatingActionButton: LiquidFloatingActionButton!
    var floatingButtonLoaded = false

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if (floatingButtonLoaded) {
            var frame = self.floatingActionButton.frame;
            frame.origin.y = scrollView.contentOffset.y + self.tableView.frame.size.height - self.floatingActionButton.frame.size.height - 10;
            self.floatingActionButton.frame = frame;
    
            self.view.bringSubviewToFront(floatingActionButton)
        }
    }
    
    private func createFloatingButtons() {
        self.cells.append(createButtonCell("AtoZIcon"))
        self.cells.append(createButtonCell("numberIcon"))
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let floatingButton = createButton(floatingFrame, style: .Up)
        
        print(self.myInfo.valueForKey("orderBy") as! String)
        if (self.myInfo.valueForKey("orderBy") as! String == "Admission Year") {
            floatingButton.image = UIImage(named: "numberIcon")
        }
        else {
            floatingButton.image = UIImage(named: "AtoZIcon")
        }
        
        self.view.addSubview(floatingButton)
        self.floatingActionButton = floatingButton
        self.floatingButtonLoaded = true
    }
    
    private func createButtonCell(iconName: String) -> LiquidFloatingCell {
        
        return LiquidFloatingCell(icon: UIImage(named: iconName)!)
        
    }
    
    private func createButton(frame: CGRect, style: LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton {
        let floatingActionButton = LiquidFloatingActionButton(frame: frame)
        
        floatingActionButton.animateStyle = style //up, down, right, left
        floatingActionButton.dataSource = self
        floatingActionButton.delegate = self
        
        return floatingActionButton
    }
    
    @IBAction func logOutButtonListner(sender: AnyObject) {
        let userInfo = NSUserDefaults.standardUserDefaults()
        userInfo.setObject(nil, forKey:"userIdentifier")
        //dismissViewControllerAnimated(true, completion:nil)
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func profileButtonListner(sender: AnyObject) {
        self.performSegueWithIdentifier("selfProfileSegue", sender: self)
    }
    
    func refresh(sender:AnyObject) {
        viewDidLoad()

    }
    
    override func viewDidLoad() {
        var temp = NSDictionary()
        self.rowCount = 0;
        
        self.refreshCtrl.addTarget(self, action: #selector(ContactListViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView?.addSubview(refreshCtrl)
        self.refreshCtrl.beginRefreshing()
        var orderBy = "Admission Year"
        
        if (self.userID == "") {
            let userInfo = NSUserDefaults.standardUserDefaults()
            self.userID = userInfo.valueForKey("userIdentifier") as! String
        }
        
        self.ref.child("Users").observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            // Get user value
            self.postDict = snapshot.value as! [NSString : [NSString : AnyObject]]
            self.keys = self.postDict.allKeys
            var iter = 0
            let executive = self.postDict.valueForKey(self.userID as String)?.valueForKey("executive")
            let isExecutive = executive as! Bool
            for key in self.keys {
                temp = self.postDict.objectForKey(key as! String) as! NSDictionary
                if (key as? NSString != self.userID && isExecutive) {
                    self.rowCount = self.postDict.count - 1
                    self.contactList[iter] = temp
                    self.names.addObject(temp.valueForKey("Last Name") as! String)
                    self.years.addObject(temp.valueForKey("Admission Year") as! NSNumber)
                    iter += 1
                }
                else if (key as! String != self.userID as String) {
                    print(temp.objectForKey("contactPublic"))
                    let contactPublic = temp.valueForKey("contactPublic")
                    let isContactPublic = contactPublic as! Bool
                    if (isContactPublic) {
                        self.rowCount += 1
                        self.contactList[iter] = temp
                        self.names.addObject(temp.valueForKey("Last Name") as! String)
                        self.years.addObject(temp.valueForKey("Admission Year") as! NSNumber)
                        iter += 1
                    }
                }
                else {
                    self.myInfo = NSMutableDictionary(dictionary : temp)
                    if (temp.valueForKey("orderBy") as? String != orderBy) {
                        orderBy = "Last Name"
                    }
                }
            }
            self.tableView.reloadData()
            if (self.refreshCtrl.refreshing) {
                self.refreshCtrl.endRefreshing()
            }
            
            //to sort by names
            
            let sortedKeys: NSArray!
            
            if (orderBy == "Admission Year") {
                sortedKeys = self.years.sort {$0.compare($1 as! NSNumber) == NSComparisonResult.OrderedAscending } as NSArray
            }
            else {
                sortedKeys = self.names.sort { $0.localizedCaseInsensitiveCompare($1 as! String) == NSComparisonResult.OrderedAscending } as NSArray
            }
            
            var j = 0
            for key in sortedKeys {
                var i = 0
                while (i < self.contactList.count) {
                    if (orderBy == "Last Name") {
                        if(self.contactList.objectForKey(i)!.valueForKey(orderBy) as! String == key as! String) {
                            self.sortedContactList[j] = self.contactList.objectForKey(i)
                            break;
                        }
                    }
                    else if (orderBy == "Admission Year"){
                        if(self.contactList.objectForKey(i)!.valueForKey(orderBy) as! Int == key as! Int) {
                            self.sortedContactList[j] = self.contactList.objectForKey(i)
                            break;
                        }
                    }
                    i += 1
                }
                j += 1
            }
            self.createFloatingButtons()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getUserId(uid: NSString) {
        self.userID = uid
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.rowCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell") as! ContactCell
        
        if (self.sortedContactList.count > 0) {
            //print(self.contactList.objectForKey(String(indexPath.row)))
            let temp = self.sortedContactList.objectForKey(indexPath.row) as? NSDictionary
            cell.department.text = temp!.valueForKey("Program") as? String
            let firstName = temp!.valueForKey("First Name") as? String
            let lastName = temp!.valueForKey("Last Name") as? String
            let fullName = firstName! + " " + lastName!
            cell.name.text = fullName
        
            let admissionYear = temp!.valueForKey("Admission Year")
            let admissionYearStr = temp!.valueForKey("Admission Year") as? String
            var admissionYearInt: Int
            if (postDict.count > 0 && admissionYearStr == nil) {
                admissionYearInt = admissionYear as! Int
                cell.year.text = String(admissionYearInt)
            }
            else if (postDict.count > 0) {
                cell.year.text = admissionYearStr
            }
            let strBase64 = temp!.valueForKey("profileImage") as? String
            if (strBase64 != nil) {
                let dataDecoded:NSData = NSData(base64EncodedString: strBase64!,options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
                let decodedimage:UIImage = UIImage(data: dataDecoded)!
                cell.thumbnail.image = decodedimage
            }
            else {
                let image: UIImage = UIImage(named: "ic_account_circle")!
                cell.thumbnail.image = image
            }
        }
        
        return cell

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.profileInfo = (self.sortedContactList.objectForKey(indexPath.row) as? NSDictionary)!
        performSegueWithIdentifier("profilePageViewSegue", sender: self)
        //NSLog("Touch Table Row at %d", indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "selfProfileSegue") {
            let next = segue.destinationViewController as! selfProfileViewController
            next.getUserId(self.userID)
            next.myInfo = self.myInfo
            //next.getMyInfo(self.myInfo)
        }
        else if (segue.identifier == "profilePageViewSegue") {
            let next = segue.destinationViewController as! ProfilePageViewController
            next.getProfileInfo(self.profileInfo)
        }
    }
}

extension ContactListViewController: LiquidFloatingActionButtonDataSource {
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return self.cells.count
    }
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return self.cells[index]
    }
}

extension ContactListViewController: LiquidFloatingActionButtonDelegate {
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        let temp = ["AtoZIcon", "numberIcon"]
        self.floatingActionButton.image = UIImage(named: temp[index])
        
        var sortedKeys: NSArray!
        var keyCompare: String!
        
        if (index == 0) {
            sortedKeys = self.names.sort {$0.localizedCaseInsensitiveCompare($1 as! String) == NSComparisonResult.OrderedAscending } as NSArray
            keyCompare = "Last Name"
            
        }
        else {
            sortedKeys = self.years.sort {$0.compare($1 as! NSNumber) == NSComparisonResult.OrderedAscending } as NSArray
            keyCompare = "Admission Year"
        }
        
        self.ref.child("Users").child(self.userID as String).child("orderBy").setValue(keyCompare)
        
        var j = 0
        for key in sortedKeys {
            var i = 0
            while (i < self.contactList.count) {
                if (index == 0) {
                    if(self.contactList.objectForKey(i)!.valueForKey(keyCompare) as! String == key as! String) {
                        self.sortedContactList[j] = self.contactList.objectForKey(i)
                        break;
                    }
                }
                else {
                    if(self.contactList.objectForKey(i)!.valueForKey(keyCompare) as! Int == key as! Int) {
                        self.sortedContactList[j] = self.contactList.objectForKey(i)
                        break;
                    }
                }
                i += 1
            }
            j += 1
        }
        
        self.tableView.reloadData()
        
        self.floatingActionButton.close()
    }
}



       