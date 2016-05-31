//
//  ViewController.swift
//  KesaApplication
//
//  Created by James on 2016-05-08.
//  Copyright (c) 2016 kesa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
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
        
        firstName.delegate = self // set delegate to 4 text fields
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
        
    }
    
    @IBAction func onLoginButtonClickListener(sender: UIButton) {
        
        /* Once login button is pressed, text fields are no longer important */
        self.firstName.resignFirstResponder() // Give up first responder status
        self.lastName.resignFirstResponder()
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    
    /* When the screen is touched */
    override func touchesBegan(touches: Set<UITouch>,
                               withEvent event: UIEvent?) {
        self.view.endEditing(true) /* For instances where the keyboard is 
                                      already brought up, Hide the keyboard */
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.blackColor()
    }
    
    
    
    // Highlighting each labels when their text fields are chosen
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if (textField == firstName) {
            firstNameLabel.textColor = UIColor.orangeColor()
            lastNameLabel.textColor = UIColor.blackColor()
            emailLabel.textColor = UIColor.blackColor()
            passwordLabel.textColor = UIColor.blackColor()
        }

        else if (textField == lastName) {
            firstNameLabel.textColor = UIColor.blackColor()
            lastNameLabel.textColor = UIColor.orangeColor()
            emailLabel.textColor = UIColor.blackColor()
            passwordLabel.textColor = UIColor.blackColor()
        }
        
        else if (textField == email) {
            firstNameLabel.textColor = UIColor.blackColor()
            lastNameLabel.textColor = UIColor.blackColor()
            emailLabel.textColor = UIColor.orangeColor()
            passwordLabel.textColor = UIColor.blackColor()
        }

        else {
            firstNameLabel.textColor = UIColor.blackColor()
            lastNameLabel.textColor = UIColor.blackColor()
            emailLabel.textColor = UIColor.blackColor()
            passwordLabel.textColor = UIColor.orangeColor()
        }
        
    }
    
    
    @IBAction func onCreateAccountButtonClickListener(sender: UIButton) {
        
        let utility = Utility() // An instance of the Utility Class
        
        let userFirstName = firstName.text
        let userLastName = lastName.text
        let userEmail = email.text
        let userPassword = password.text
        
        // Booleans to check if the names have numbers included in them 
        let checkFirstName = utility.isValidNameFormat(userFirstName!)
        let checkLastName = utility.isValidNameFormat(userLastName!)
        
        /* Check for empty fields */
        if (userFirstName!.isEmpty) {
            
            // Display alert message
            displayAlertMessage ("First name field is required");
            
            return
        }
        
        
        else if (userLastName!.isEmpty) {
         
            displayAlertMessage("Last name field is required")
            
            return
        }
            
        else if (userEmail!.isEmpty) {
            
            displayAlertMessage("Email field is required")
            
            return
        }
            
        else if (userPassword!.isEmpty) {
            
            displayAlertMessage("Password field is required")
            
            return
        }
        
        // check if the names are valid (no numbers included)
        else if (!checkFirstName) {
            
            displayAlertMessage("Invalid first name")
            
            return
        }
        
        else if (!checkLastName) {
            
            displayAlertMessage("Invalid last name")
            
            return
        }
        
        else { // Email validity check
            
            if utility.isValidEmailFormat(userEmail!)  {
            
            
                // Store data and etc
            
            }
            
            else {
                displayAlertMessage ("Invalid email address")
            
                return
            }
        }
    }
 
    
    /* Function for displaying alert messages */
    func displayAlertMessage (userMessage: String){
        
        let alert = UIAlertController(title: "Alert", message: userMessage,
                                      preferredStyle:
                                      UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: UIAlertActionStyle.Default,
                                     handler: nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

