//
//  editViewController.swift
//  KesaApplication
//
//  Created by Jeff on 2016. 6. 29..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit
import Firebase

class editViewController: UIViewController, UITextFieldDelegate {
    
    var tempTitle = NSString()
    var tempSubTitle = NSString()
    var userID = NSString()
    var myInfo = NSMutableDictionary()
    
    let accountManager:AccountManager = AccountManager()
    let ref = FIRDatabase.database().reference()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleText: UITextField!
    
    @IBAction func cancelButtonListner(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButtonListner(sender: AnyObject) {
        let isNameValid = Utility.isValidNameFormat(tempTitle as String)
        let isEmailValid = Utility.isValidEmailFormat(tempTitle as String)
        
        if (tempTitle == "E-mail" && !isEmailValid) {
                Utility.displayAlertMessage ("Modified E-mail format is invalid",
                                             viewController: self);
        }
        else if ((tempTitle == "First Name" || tempTitle == "Last Name") && !isNameValid) {
                Utility.displayAlertMessage ("Modified name format is invalid",
                                             viewController: self);
        }
        else if (subTitleText.text == "") {
            Utility.displayAlertMessage ("A required field is empty. Please fill it out",
                                         viewController: self);
        }
        else {
            //upload to database
            self.ref.child("Users").child(self.userID as String).child(tempTitle as String).setValue(subTitleText.text)
            self.myInfo[tempTitle as String] = subTitleText.text
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func getTitle(title: NSString) {
        tempTitle = title as String
    }
    
    func getSubTitle(subTitle: NSString) {
        tempSubTitle = subTitle as String
    }
    
    func getUserId(uid: NSString) {
        self.userID = uid
    }
    
    func getMyInfo(info:NSMutableDictionary) {
        self.myInfo = info
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        titleLabel.textColor = UIColor.blackColor()
        
        switch textField {
        case subTitleText:
            titleLabel.textColor = UIColor.orangeColor()
        default:
            break
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>,
                               withEvent event: UIEvent?) {
        titleLabel.textColor = UIColor.blackColor()
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = tempTitle as String
        subTitleText.text = tempSubTitle as String
        subTitleText.placeholder = tempTitle as String
        subTitleText.delegate = self
        
        
        if (tempTitle as String == "Phone Number") {
            self.subTitleText.keyboardType = .NumberPad
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
