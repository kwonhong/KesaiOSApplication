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
    var contactList = NSDictionary()
    var rowCount = NSInteger()
    var keys = NSArray()
    
    @IBAction func logOutButtonListner(sender: AnyObject) {
        let userInfo = NSUserDefaults.standardUserDefaults()
        userInfo.setObject(nil, forKey:"email")
        //dismissViewControllerAnimated(true, completion:nil)
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func profileButtonListner(sender: AnyObject) {
        self.performSegueWithIdentifier("selfProfileSegue", sender: self)
    }
    
    override func viewDidLoad() {
        let ref = FIRDatabase.database().reference()
        var temp = NSDictionary()
        self.rowCount = 0;
        
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
                    self.contactList = [iter : temp]
                    iter += 1
                }
                else if (key as! String != self.userID as String){
                    print(temp.objectForKey("contactPublic"))
                    let contactPublic = temp.valueForKey("contactPublic")
                    let isContactPublic = contactPublic as! Bool
                    if (isContactPublic) {
                        self.rowCount += 1
                        self.contactList = [iter : temp]
                        iter += 1
                    }
                }
            }
            self.tableView.reloadData()
            
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
        
        if (contactList.count > 0) {
            //print(self.contactList.objectForKey(String(indexPath.row)))
            let temp = self.contactList.objectForKey(indexPath.row) as? NSDictionary
            cell.department.text = temp!.valueForKey("program") as? String
            let firstName = temp!.valueForKey("firstName") as? String
            let lastName = temp!.valueForKey("lastName") as? String
            let fullName = firstName! + " " + lastName!
            cell.name.text = fullName
        
            let test = temp!.valueForKey("admissionYear")
            let test3 = temp!.valueForKey("admissionYear") as? String
            var test2: Int
            if (postDict.count > 0 && test3 == nil) {
                test2 = test as! Int
                cell.year.text = String(test2)
            }
            else if (postDict.count > 0) {
                cell.year.text = test3
            }
        }
        
        return cell

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("profilePageViewSegue", sender: self)
        //NSLog("Touch Table Row at %d", indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "selfProfileSegue") {
            let next = segue.destinationViewController as! selfProfileViewController
            next.getUserId(self.userID)
        }
    }
}

       