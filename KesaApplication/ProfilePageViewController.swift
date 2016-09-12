//
//  ProfilePageViewController.swift
//  KesaApplication
//
//  Created by Joon Lee on 2016-07-23.
//  Copyright © 2016 kesa. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    
    var profileInfo = NSDictionary()
    
    func getProfileInfo(info: NSDictionary) {
        self.profileInfo = info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        
        profilePicture.layer.borderColor = UIColor.clearColor().CGColor
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.clipsToBounds = true
        
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        firstTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        firstTableView.separatorInset.left = 0
        
        secondTableView.delegate = self
        secondTableView.dataSource = self
        secondTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        secondTableView.separatorInset.left = 0
        
        firstTableView.layer.cornerRadius = 10
        secondTableView.layer.cornerRadius = 10
        
        
        //let image: UIImage = UIImage(named: "ic_account_circle")!
        //profilePicture.image = image
        let strBase64 = self.profileInfo.valueForKey("profileImage") as? String
        if (strBase64 == nil) {
            let image: UIImage = UIImage(named: "ic_account_circle")!
            self.profilePicture.image = image
        }
        else {
            let dataDecoded:NSData = NSData(base64EncodedString: strBase64!, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            self.profilePicture.image = decodedimage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(currentTableView: UITableView, numberOfRowsInSection section: Int)->Int {
        
        if (currentTableView == firstTableView){
            return 4
        }
        else {
            return 2
        }
    }
    
    func tableView(currentTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if (currentTableView == firstTableView){
            cell = firstTableView.dequeueReusableCellWithIdentifier("firstTableViewCell", forIndexPath: indexPath) as UITableViewCell
        }
        else {
            cell = secondTableView.dequeueReusableCellWithIdentifier("secondTableViewCell", forIndexPath: indexPath) as UITableViewCell
        }
        
        if (indexPath.row == 0) {
            if (currentTableView == firstTableView) {
                cell.textLabel?.text = "First Name"
                cell.detailTextLabel?.text = self.profileInfo.valueForKey("First Name") as? String
            }
            else {
                cell.textLabel?.text = "Mobile"
                let test = self.profileInfo.objectForKey("Mobile")
                var test2: Int
                if (self.profileInfo.count > 0) {
                    test2 = test as!Int
                    cell.detailTextLabel?.text = String(test2)
                }
                else {
                    cell.detailTextLabel?.text = ""
                }
            }
        }
        else if (indexPath.row == 1) {
            if (currentTableView == firstTableView) {
                cell.textLabel?.text = "Last Name"
                cell.detailTextLabel?.text = self.profileInfo.valueForKey("Last Name") as? String
            }
            else {
                cell.textLabel?.text = "E-mail"
                cell.detailTextLabel?.text = self.profileInfo.valueForKey("E-mail") as? String
            }
        }
        else if (indexPath.row == 2) {
            cell.textLabel?.text = "Program"
            cell.detailTextLabel?.text = self.profileInfo.valueForKey("Program") as? String
        }
        else if (indexPath.row == 3) {
            cell.textLabel?.text = "Admission Year"
            //cell.detailTextLabel?.text = self.profileInfo.valueForKey("admissionYear") as? String
            let test = self.profileInfo.objectForKey("Admission Year")
            let temp = self.profileInfo.objectForKey("Admission Year") as? String
            var test2: Int
            if (self.profileInfo.count > 0 && temp == nil) {
                test2 = test as! Int
                cell.detailTextLabel?.text = String(test2)
            }
            else if (self.profileInfo.count > 0) {
                cell.detailTextLabel?.text = temp;
            }
            else {
                cell.detailTextLabel?.text = ""
            }
            
        }
        
        
        return cell
    }

}
