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
    var myInfo = NSMutableDictionary()
    
    let profilePicture64Str = NSString()
    let ref = FIRDatabase.database().reference()
    
    
    func getUserId(uid: NSString) {
        self.userID = uid
    }
    
    func getMyInfo(info: NSDictionary) {
        self.myInfo = NSMutableDictionary(dictionary : info)
    }
    
    @IBAction func changePictureListner(sender: AnyObject) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func contactInfoButtonListner(sender: AnyObject) {
        let alert = UIAlertController(title: "Contact Sharing", message: "Are you sure? Turning this on will make your contact information visible to anyone. By default, the contact information is only visible to executive members", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: {action in self.Continue()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {action in self.Cancel()}))
        
        if(self.contactInfoButton.on == true) {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            self.ref.child("Users").child(self.userID as String).child("contactPublic").setValue(false)
        }
    }
    
    func Cancel() {
        if (self.contactInfoButton.on == true) {
            self.contactInfoButton.on = false
        }
        else {
            self.contactInfoButton.on = true
        }
    }
    
    func Continue() {
        if (contactInfoButton.on == true) {
            self.ref.child("Users").child(self.userID as String).child("contactPublic").setValue(true)
        }
        else {
            self.ref.child("Users").child(self.userID as String).child("contactPublic").setValue(false)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.ref.child("Users").child(self.userID as String).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
            // Get user value
            //let username = snapshot.value!["username"] as! String
            //let user = User.init(username: username)
          //  self.postDict = snapshot.value as! [NSString : AnyObject]
            
        
            
            self.topProfileTableView.reloadData()
            self.bottomProfileTableView.reloadData()
            
            // ...
        //}) { (error) in
            //print(error.localizedDescription)
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changePicture.setImage(UIImage(named: "ic_mode_edit"), forState: .Normal)
        self.changePicture.setTitle("change picture", forState: .Normal)
        self.changePicture.backgroundColor? = UIColor.clearColor()
        
        self.topProfileTableView.delegate = self
        self.topProfileTableView.dataSource = self
        self.topProfileTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.topProfileTableView.separatorInset.left = 0
        
        self.bottomProfileTableView.delegate = self
        self.bottomProfileTableView.dataSource = self
        self.bottomProfileTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.bottomProfileTableView.separatorInset.left = 0
        
        self.imagePicker.delegate = self
        
        self.profilePicture.layer.borderColor = UIColor.clearColor().CGColor
        self.profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        self.profilePicture.clipsToBounds = true
        
        let strBase64 = self.myInfo.valueForKey("profileImage") as? String
        if (strBase64 == nil) {
            let image: UIImage = UIImage(named: "ic_account_circle")!
            self.profilePicture.image = image
        }
        else {
            let dataDecoded:NSData = NSData(base64EncodedString: strBase64!, options:NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            self.profilePicture.image = decodedimage
        }
        
        let contactPublic = self.myInfo.valueForKey("contactPublic")
        let iscontactPublic = contactPublic as! Bool
        if (iscontactPublic) {
            self.contactInfoButton.on = true
        }
        else {
            self.contactInfoButton.on = false
        }
        
        
        self.contactInformationView.layer.cornerRadius = 10
        self.topProfileTableView.layer.cornerRadius = 10
        self.bottomProfileTableView.layer.cornerRadius = 10
        
        
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
            
            let imageData:NSData = UIImageJPEGRepresentation(pickedImage, 0.5)!
            //encoding
            let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            self.ref.child("Users").child(self.userID as String).child("profileImage").setValue(strBase64)
            self.myInfo["profileImage"] = strBase64

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
                cell.detailTextLabel?.text = self.myInfo.valueForKey("First Name") as? String
            }
            else {
                cell.textLabel?.text = "Mobile"
                let mobile = self.myInfo.objectForKey("Mobile")
                var mobileInt: Int
                if (self.myInfo.count > 0) {
                    mobileInt = mobile as!Int
                    cell.detailTextLabel?.text = String(mobileInt)
                }
                else {
                    cell.detailTextLabel?.text = ""
                }
            }
        }
        else if (indexPath.row == 1) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "Last Name"
                cell.detailTextLabel?.text = self.myInfo.valueForKey("Last Name") as? String
            }
            else {
                cell.textLabel?.text = "E-mail"
                cell.detailTextLabel?.text = self.myInfo.valueForKey("E-mail") as? String
            }
        }
        else if (indexPath.row == 2) {
            if (currentTableView == topProfileTableView) {
                cell.textLabel?.text = "Program"
                cell.detailTextLabel?.text = self.myInfo.valueForKey("Program") as? String
            }
            else {
                cell.textLabel?.text = "Contact Method"
                cell.detailTextLabel?.text = self.myInfo.valueForKey("contactMethod") as? String
            }
        }
        else if (indexPath.row == 3) {
            cell.textLabel?.text = "Admission Year"
            //cell.detailTextLabel?.text = self.myInfo.valueForKey("admissionYear") as? String
            let admissionYear = self.myInfo.objectForKey("Admission Year")
            let admissionYearStr = self.myInfo.objectForKey("Admission Year") as? String
            var admissionYearInt: Int
            if (self.myInfo.count > 0 && admissionYearStr == nil) {
                admissionYearInt = admissionYear as! Int
                cell.detailTextLabel?.text = String(admissionYearInt)
            }
            else if (myInfo.count > 0) {
                cell.detailTextLabel?.text = admissionYearStr;
            }
            else {
                cell.detailTextLabel?.text = ""
            }
            
        }
        if (currentTableView == topProfileTableView) {
            textlabelArray.insertObject((cell.textLabel?.text)!, atIndex: indexPath.row + 3)
            if (self.myInfo.count > 0) {
                detailedTextLabelArray.insertObject((cell.detailTextLabel?.text)!, atIndex: indexPath.row + 3)
            }
        }
        else {
            textlabelArray.insertObject((cell.textLabel?.text)!, atIndex: indexPath.row)
            if (self.myInfo.count > 0) {
                detailedTextLabelArray.insertObject((cell.detailTextLabel?.text)!, atIndex: indexPath.row)
            }
        }
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(currentTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (currentTableView == topProfileTableView) {
            self.selectedTextLabel = textlabelArray.objectAtIndex(indexPath.row + 3) as! NSString
            self.selectedDetailedTextLabel = detailedTextLabelArray.objectAtIndex(indexPath.row + 3) as! NSString
        }
        else {
            self.selectedTextLabel = textlabelArray.objectAtIndex(indexPath.row) as! NSString
            self.selectedDetailedTextLabel = detailedTextLabelArray.objectAtIndex(indexPath.row) as! NSString
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
            next.getTitle(self.selectedTextLabel)
            next.getSubTitle(self.selectedDetailedTextLabel)
            next.getUserId(self.userID)
            next.myInfo = self.myInfo
        }
        else if (segue.identifier == "contactMethodSegue") {
            let next = segue.destinationViewController as! contactMethodViewController
            next.getCurrentMethod(self.selectedDetailedTextLabel)
            next.getUserID(self.userID)
            next.myInfo = self.myInfo
        }
    }
 

}
