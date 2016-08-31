//
//  ContactListViewController.swift
//  KesaApplication
//
//  Created by Jiwoo Lim on 2016. 7. 19..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit


import UIKit

class ContactListViewController : UITableViewController {
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return kJUSTUnlimited
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell") as! ContactCell
        
        
        return cell

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("Touch Table Row at %d", indexPath.row)
    }
}

       