//
//  ContactListViewController.swift
//  KesaApplication
//
//  Created by Jiwoo Lim on 2016. 7. 19..
//  Copyright © 2016년 kesa. All rights reserved.
//


import UIKit
import Firebase

class ContactListViewController : UITableViewController {
    
    var userID = NSString()
    var postDict = NSDictionary()
    var myInfo = NSMutableDictionary()
    var rowCount = NSInteger()
    var keys = NSArray()
    var profileInfo = NSDictionary()
    var refreshCtrl = UIRefreshControl()
    var names = NSMutableArray()
    var sortedContactList = NSMutableDictionary()
    
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
        let ref = FIRDatabase.database().reference()
        var temp = NSDictionary()
        let contactList = NSMutableDictionary()
        self.rowCount = 0;
        
        self.refreshCtrl.addTarget(self, action: #selector(ContactListViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView?.addSubview(refreshCtrl)
        self.refreshCtrl.beginRefreshing()
        
        if (self.userID == "") {
            let userInfo = NSUserDefaults.standardUserDefaults()
            self.userID = userInfo.valueForKey("userIdentifier") as! String
        }
        
        ref.child("Users").observeSingleEventOfType(.Value, withBlock: {(snapshot) in
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
                    contactList[iter] = temp
                    self.names.addObject(temp.valueForKey("First Name") as! String)
                    iter += 1
                }
                else if (key as! String != self.userID as String) {
                    print(temp.objectForKey("contactPublic"))
                    let contactPublic = temp.valueForKey("contactPublic")
                    let isContactPublic = contactPublic as! Bool
                    if (isContactPublic) {
                        self.rowCount += 1
                        contactList[iter] = temp
                        self.names.addObject(temp.valueForKey("First Name") as! String)
                        iter += 1
                    }
                }
                else {
                    self.myInfo = NSMutableDictionary(dictionary : temp)
                }
            }
            self.tableView.reloadData()
            if (self.refreshCtrl.refreshing) {
                self.refreshCtrl.endRefreshing()
            }
            
            //to sort by names
            let sortedNames = self.names.sort { $0.localizedCaseInsensitiveCompare($1 as! String) == NSComparisonResult.OrderedAscending } as NSArray
            
            var j = 0
            for name in sortedNames {
                var i = 0
                while (i < contactList.count) {
                    if(contactList.objectForKey(i)!.valueForKey("First Name") as! String == name as! String) {
                        self.sortedContactList[j] = contactList.objectForKey(i)
                        break;
                    }
                    i += 1
                }
                j += 1
            }
            
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

       