/**
 Login Page
 
 @author Jiwoo
 */

import UIKit

class LoginViewController: UIViewController {
    
    let accountManager:AccountManager = AccountManager()
    
    // TODO(jiwoo): Refactor this function into utility class
    func displayAlertMessage(userMessage: String){
        let myAlert = UIAlertController(title: "Error",
                                        message: userMessage,
                                        preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.Default,
                                     handler:nil);
            myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
    }
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBAction func onLoginButtonClickListener(sender: AnyObject) {
        let userEmail = userEmailTextField.text!;
        if userEmail.isEmpty {
                displayAlertMessage("Please enter your email")
        }
        let userPassword = userPasswordTextField.text!;
        if userPassword.isEmpty {
            displayAlertMessage("Please enter your password")
        }
        
        let resultHandler = ResultHandler()
        resultHandler.onSuccessCallback = {
            // TODO(jiwoo): Handle authentication success case.
        }
        resultHandler.onErrorCallback = { error in
            // TODO(jiwoo): Handle authentication error case.
        }
        
        accountManager
            .authenticateWithPassword(userEmail,
                                      password: userPassword,
                                      resultHandler: resultHandler)
        
        //Hide Keyboard when login button clicked
        self.userEmailTextField.resignFirstResponder()
        self.userPasswordTextField.resignFirstResponder()
    }
    
    //Hide Keyboard when background clicked
    override func touchesBegan(touches: Set<UITouch>,
                               withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
