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
    
    /* Function to help check for the email validity */
    func isValidEmailFormat (testEmail:String) -> Bool {
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testEmail)
        
        return result
    }
    
    
    
    /* Function to help check names with numbers */
    func isValidNameFormat (testName:String) -> Bool {
        
        let decimalCharacters = NSCharacterSet.decimalDigitCharacterSet()
        
        let decimalRange = testName.rangeOfCharacterFromSet(decimalCharacters,
                                                            options:
                                                    NSStringCompareOptions(),
                                                            range: nil)
        
        if decimalRange != nil {
            return false
        }
        
        return true
    }
    
    
}