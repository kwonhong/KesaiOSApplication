//
//  Utility.swift
//  KesaApplication
//
//  Created by Joon Lee on 2016-05-30.
//  Copyright © 2016 kesa. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    class func isValidEmailFormat (email:String) -> Bool {
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(email)
        
        return result
    }
    
    
    class func isValidNameFormat (name:String) -> Bool {
        
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        let decimalRange =
            name.rangeOfCharacterFromSet(decimalCharacters,
                                         options: NSStringCompareOptions(),
                                         range: nil)
        
        return decimalRange == nil
    }
    
    
    class func displayAlertMessage (userMessage: String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: "Alert",
                                      message: userMessage,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: UIAlertActionStyle.Default,
                                     handler: nil)
        
        alert.addAction(okAction)
        
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}