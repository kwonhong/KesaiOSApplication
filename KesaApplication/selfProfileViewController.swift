//
//  versionViewController.swift
//  KesaApplication
//
//  Created by Jeff on 2016. 6. 29..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit
import Firebase

class selfProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var changePicture: UIButton!
    @IBOutlet weak var topProfileTableView: UITableView!
    @IBOutlet weak var bottomProfileTableView: UITableView!
    @IBOutlet weak var contactInformationView: UIView!
    @IBOutlet weak var contactInfoButton: UISwitch!
    
    let imagePicker = UIImagePickerController()
    var textlabelArray = NSMutableArray()
    var detailedTextLabelArray = NSMutableArray()
    var selectedTextLabel = NSString()
    var selectedDetailedTextLabel = NSString()
    var userID = NSString()
    var postDict = NSDictionary()
    
    
    func getUserId(uid: NSString) {
        self.userID = uid
    }
    
    @IBAction func changePictureListner(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func contactInfoButtonListner(sender: AnyObject) {
        let alert = UIAlertController(title: "Contact Sharing", message: "Are you sure? Turning this on will make your contact information visible to anyone. By default, the contact information is only visible to executive members", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {action in self.Cancel()}))
        
        if(contactInfoButton.on == true) {
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func Cancel() {
        if (contactInfoButton.on == true) {
            contactInfoButton.on = false
        }
        else {
            contactInfoButton.on = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadInputViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePicture.setImage(UIImage(named: "ic_mode_edit"), forState: .Normal)
        changePicture.setTitle("change picture", forState: .Normal)
        changePicture.backgroundColor? = UIColor.clearColor()
        
        topProfileTableView.delegate = self
        topProfileTableView.dataSource = self
        topProfileTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        topProfileTableView.separatorInset.left = 0
        
        bottomProfileTableView.delegate = self
        bottomProfileTableView.dataSource = self
        bottomProfileTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        bottomProfileTableView.separatorInset.left = 0
        
        imagePicker.delegate = self
        
        profilePicture.layer.borderColor = UIColor.clearColor().CGColor
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.clipsToBounds = true
        if (profilePicture.image == nil) {
            let image: UIImage = UIImage(named: "ic_account_circle")!
            profilePicture.image = image
        }
        
        contactInformationView.layer.cornerRadius = 10
        topProfileTableView.layer.cornerRadius = 10
        bottomProfileTableView.layer.cornerRadius = 10
        
        let ref = FIRDatabase.database().reference()
        
        //ref.child("Users").child(self.userID as String).observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
        ref.child("Users").child(self.userID as String).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            // Get user value
            //let username = snapshot.value!["username"] as! String
            //let user = User.init(username: username)
            self.postDict = snapshot.value as! [NSString : AnyObject]
            self.topProfileTableView.reloadData()
            self.bottomProfileTableView.reloadData()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicture.layer.borderColor = UIColor.clearColor().CGColor
            profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
            profilePicture.clipsToBounds = true
            profilePicture.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(currentTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (currentTableView == topProfileTableView) {
            return 4
        }
        else{
            return 3
        }
    }
    
    
    func tableView(currentTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if (currentTableView == topProfileTableView) {
            cell = topProfileTableView.dequeueReusableCellWithIdentifier("topTableViewCell", forIndexPath: indexPath) as UITableViewCell
        }
        else {
            cell = bottomProfileTableView.dequeueReusableCellWithIdentifier("bottomTableViewCell", forIndexPath: indexPath) as UITableViewCell
        }
        
        if (indexPath.row == 0) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "First Name"
                cell.detailTextLabel?.text = self.postDict.valueForKey("firstName") as? String
            }
            else {
                cell.textLabel?.text = "Phone Number"
                let test = self.postDict.objectForKey("mobile")
                var test2: Int
                if (postDict.count > 0) {
                    test2 = test as!Int
                    cell.detailTextLabel?.text = String(test2)
                }
                else {
                    cell.detailTextLabel?.text = ""
                }
            }
        }
        else if (indexPath.row == 1) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "Last Name"
                cell.detailTextLabel?.text = self.postDict.valueForKey("lastName") as? String
            }
            else {
                cell.textLabel?.text = "E-mail"
                cell.detailTextLabel?.text = self.postDict.valueForKey("email") as? String
            }
        }
        else if (indexPath.row == 2) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "Program"
                cell.detailTextLabel?.text = self.postDict.valueForKey("program") as? String
            }
            else {
                cell.textLabel?.text = "Contact Method"
                cell.detailTextLabel?.text = self.postDict.valueForKey("contactMethod") as? String
            }
        }
        else if (indexPath.row == 3) {
            cell.textLabel?.text = "Admission Year"
            //cell.detailTextLabel?.text = self.postDict.valueForKey("admissionYear") as? String
            let test = self.postDict.objectForKey("admissionYear")
            let temp = self.postDict.objectForKey("admissionYear") as? String
            var test2: Int
            if (postDict.count > 0 && temp == nil) {
                test2 = test as! Int
                cell.detailTextLabel?.text = String(test2)
            }
            else if (postDict.count > 0) {
                cell.detailTextLabel?.text = temp;
            }
            else {
                cell.detailTextLabel?.text = ""
            }
            
        }
        if (currentTableView == topProfileTableView) {
            textlabelArray.insertObject((cell.textLabel?.text)!, atIndex: indexPath.row + 3)
            if (postDict.count > 0) {
                detailedTextLabelArray.insertObject((cell.detailTextLabel?.text)!, atIndex: indexPath.row + 3)
            }
        }
        else {
            textlabelArray.insertObject((cell.textLabel?.text)!, atIndex: indexPath.row)
            if (postDict.count > 0) {
                detailedTextLabelArray.insertObject((cell.detailTextLabel?.text)!, atIndex: indexPath.row)
            }
        }
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(currentTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (currentTableView == topProfileTableView) {
            selectedTextLabel = textlabelArray.objectAtIndex(indexPath.row + 3) as! NSString
            selectedDetailedTextLabel = detailedTextLabelArray.objectAtIndex(indexPath.row + 3) as! NSString
        }
        else {
            selectedTextLabel = textlabelArray.objectAtIndex(indexPath.row) as! NSString
            selectedDetailedTextLabel = detailedTextLabelArray.objectAtIndex(indexPath.row) as! NSString
            if (indexPath.row == 2) {
                performSegueWithIdentifier("contactMethodSegue", sender: self)
                return
            }
        }
        performSegueWithIdentifier("editSegue", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editSegue") {
            let next = segue.destinationViewController as! editViewController
            next.getTitle(selectedTextLabel)
            next.getSubTitle(selectedDetailedTextLabel)
        }
        else if (segue.identifier == "contactMethodSegue") {
            let next = segue.destinationViewController as! contactMethodViewController
            next.getCurrentMethod(selectedDetailedTextLabel)
        }
    }
 

}
