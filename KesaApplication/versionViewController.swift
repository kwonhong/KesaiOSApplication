//
//  versionViewController.swift
//  KesaApplication
//
//  Created by Jeff on 2016. 6. 29..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit

class versionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

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
    
    @IBAction func changePictureListner(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func doneListner(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
            cell = topProfileTableView.dequeueReusableCellWithIdentifier("testCell1", forIndexPath: indexPath) as UITableViewCell
        }
        else {
            cell = bottomProfileTableView.dequeueReusableCellWithIdentifier("testCell2", forIndexPath: indexPath) as UITableViewCell
        }
        
        if (indexPath.row == 0) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "First Name"
                cell.detailTextLabel?.text = "Max"
            }
            else {
                cell.textLabel?.text = "Phone Number"
                cell.detailTextLabel?.text = "6477743186"
            }
        }
        else if (indexPath.row == 1) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "Last Name"
                cell.detailTextLabel?.text = "Kim"
            }
            else {
                cell.textLabel?.text = "E-mail"
                cell.detailTextLabel?.text = "mik7920@hotmail.com"
            }
        }
        else if (indexPath.row == 2) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "Program"
                cell.detailTextLabel?.text = "ECE"
            }
            else {
                cell.textLabel?.text = "Contact Method"
                cell.detailTextLabel?.text = "Phone Call"
            }
        }
        else if (indexPath.row == 3) {
            cell.textLabel?.text = "Admission Year"
            cell.detailTextLabel?.text = "1T7"
            
        }
        if (currentTableView == topProfileTableView) {
            textlabelArray.insertObject((cell.textLabel?.text)!, atIndex: indexPath.row + 3)
            detailedTextLabelArray.insertObject((cell.detailTextLabel?.text)!, atIndex: indexPath.row + 3)
        }
        else {
            textlabelArray.insertObject((cell.textLabel?.text)!, atIndex: indexPath.row)
            detailedTextLabelArray.insertObject((cell.detailTextLabel?.text)!, atIndex: indexPath.row)
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
