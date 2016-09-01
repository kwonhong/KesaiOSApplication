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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.blackColor().CGColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
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
                cell.detailTextLabel?.text = "Joon"
            }
            else {
                cell.textLabel?.text = "Phone Number"
                cell.detailTextLabel?.text = "6479850414"
            }
        }
        
        else if (indexPath.row == 1) {
            if (currentTableView == firstTableView) {
                cell.textLabel?.text = "Last Name"
                cell.detailTextLabel?.text = "Lee"
            }
            else {
                cell.textLabel?.text = "E-mail"
                cell.detailTextLabel?.text = "juicebox-_-rox@hotmail.com"
            }
        }
        
        else if (indexPath.row == 2) {
            cell.textLabel?.text = "Program"
            cell.detailTextLabel?.text = "ECE"
        }
        
        else if (indexPath.row == 3) {
            cell.textLabel?.text = "Admission Year"
            cell.detailTextLabel?.text = "1T8"
        }
        
        
        return cell
    }

}
