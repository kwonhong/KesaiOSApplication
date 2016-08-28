//
//  RegisterViewController.swift
//  KesaApplication
//
//  Created by Joon Lee on 2016-06-20.
//  Copyright © 2016 kesa. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
  
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting delegate property to self, so now, RegisterViewController
        // becomes the delegate of the text fields and is able to implement the
        // UITextFieldDelegate methods
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
    }
    
    
    /* When the screen is touched */
    override func touchesBegan(touches: Set<UITouch>,
                               withEvent event: UIEvent?) {
        // For instances where the keyboard is already brought up,
        // Hide the keyboard
        self.view.endEditing(true)
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.blackColor()
    }
    
    
    /* Highlighting each labels when their text fields are chosen */
    func textFieldDidBeginEditing(textField: UITextField) {
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.blackColor()
        
        switch textField {
        case firstName:
            firstNameLabel.textColor = UIColor.orangeColor()
            
        case lastName:
            lastNameLabel.textColor = UIColor.orangeColor()
            
        case email:
            emailLabel.textColor = UIColor.orangeColor()
            
        case password:
            passwordLabel.textColor = UIColor.orangeColor()
            
        default:
            break
        }
    }
    
    @IBAction func onAlreadyHaveAccountButtonClickListner(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func onCreateAccountButtonClickListener(sender: UIButton) {
        
        let userFirstName = firstName.text
        let userLastName = lastName.text
        let userEmail = email.text
        let userPassword = password.text
        
        // Booleans to check for name/email validity
        let isFirstNameValid = Utility.isValidNameFormat(userFirstName!)
        let isLastNameValid = Utility.isValidNameFormat(userLastName!)
        let isEmailValid = Utility.isValidEmailFormat(userEmail!)
        
        if (userFirstName!.isEmpty || !isFirstNameValid) {
            Utility.displayAlertMessage ("First name field is invalid",
                                         viewController: self);
            return
        } else if (userLastName!.isEmpty || !isLastNameValid) {
            Utility.displayAlertMessage("Last name field is invalid",
                                        viewController: self)
            return
        } else if (userEmail!.isEmpty || !isEmailValid) {
            Utility.displayAlertMessage("Email field is invalid",
                                        viewController: self)
            return
        } else if (userPassword!.isEmpty) {
            Utility.displayAlertMessage("Password field is required",
                                        viewController: self)
            return
        } else {
            // Store data and etc
        }
    }
}