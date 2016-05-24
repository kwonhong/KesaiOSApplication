//
//  ViewController.swift
//  KesaApplication
//
//  Created by James on 2016-05-08.
//  Copyright (c) 2016 kesa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 4 labels
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    // 4 text fields
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    // When the login button is pressed, ignore all text fields
    @IBAction func loginButtonPressed(sender: UIButton) {
        self.firstName.resignFirstResponder() // don't worry about the keyboard
        self.lastName.resignFirstResponder()
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    // When the screen is pressed while editing, hide the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.blackColor()
    }
    
    
    
    // Highlighting each labels when their text fields are pressed
    @IBAction func firstNameTextFieldPressed(sender: UITextField) {
        firstNameLabel.textColor = UIColor.orangeColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.blackColor()
    }
    
    @IBAction func lastNameTextFieldPressed(sender: UITextField) {
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.orangeColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.blackColor()
    }

    
    @IBAction func emailTextFieldPressed(sender: UITextField) {
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.orangeColor()
        passwordLabel.textColor = UIColor.blackColor()
    }
    
    @IBAction func passwordTextFieldPressed(sender: UITextField) {
        firstNameLabel.textColor = UIColor.blackColor()
        lastNameLabel.textColor = UIColor.blackColor()
        emailLabel.textColor = UIColor.blackColor()
        passwordLabel.textColor = UIColor.orangeColor()
    }
    
    
    
    // When "Create Account" button is pressed
    @IBAction func createAccountButtonPressed(sender: UIButton) {
        
        let userFirstName = firstName.text
        let userLastName = lastName.text
        let userEmail = email.text
        let userPassword = password.text
        
        // Check for empty fields
        if (userFirstName!.isEmpty || userLastName!.isEmpty ||
            userEmail!.isEmpty || userPassword!.isEmpty) {
            
            // Display alert message 
            displayAlertMessage ("All fields are required");
            
            return
        }
        
        // Email validity check
        if isValidEmail(userEmail!)  {
        
        
            // Store data
            
        }
        
        else {
            displayAlertMessage ("Invalid email address")
            
            return
        }
    }
    
    
    
    // Function for displaying alert messages
    func displayAlertMessage (userMessage: String){
        
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    // Function to help check for the email validity 
    // Returns a boolean
    func isValidEmail (testEmail:String) -> Bool {
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testEmail)
        
        return result
    }
    
}

