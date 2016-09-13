//
//  contactMethodViewController.swift
//  KesaApplication
//
//  Created by Jeff on 2016. 8. 29..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit
import Firebase

class contactMethodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var methodsTableView: UITableView!
    
    var contactMethod = NSString()
    var userID = NSString()
    var myInfo = NSMutableDictionary()
    
    let ref = FIRDatabase.database().reference()
    
    func getCurrentMethod(method: NSString) {
        contactMethod = method
    }
    
    func getUserID(uid: NSString) {
        self.userID = uid
    }
    
    @IBAction func cancelButtonListner(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        methodsTableView.delegate = self
        methodsTableView.dataSource = self
        methodsTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        methodsTableView.separatorInset.left = 0
        
        methodsTableView.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(currentTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(currentTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell = methodsTableView.dequeueReusableCellWithIdentifier("contactMethodCell", forIndexPath: indexPath) as UITableViewCell
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Phone Call"
        }
        else if (indexPath.row == 1) {
            cell.textLabel?.text = "Katalk"
        }
        else if (indexPath.row == 2) {
            cell.textLabel?.text = "Text Message"
        }
        else if (indexPath.row == 3){
            cell.textLabel?.text = "E-mail"
        }
        
        if (cell.textLabel?.text == contactMethod) {
            cell.accessoryType = .Checkmark
            cell.textLabel?.textColor = UIColor.orangeColor()
        }
        
        return cell
        
    }
    func tableView(currentTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //upload what they want
        let options = ["Phone Call", "Katalk", "Text Message", "E-mail"]
        self.ref.child("Users").child(self.userID as String).child("contactMethod").setValue(options[indexPath.row])
        self.myInfo["contactMethod"] = options[indexPath.row]
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
