import Foundation
import FirebaseAuth

/**
 A manager handling authentication into the KesaApplication using 
 the Firebase Authentication API.
 
 @author hongil
 */
public class AccountManager {
    /** A singleton instance of AccountManager class */
    private static let accountManager:AccountManager = AccountManager()
    
    /** A key used to save/retrieve the uid of the authenticated user */
    private let userIdentifierKey:String = "userIdentifier"
    
    /** Returning an instance of AccountManager class */
    public static func instanceOf() -> AccountManager {
        return accountManager
    }
    
    /** Authenticates into the application using the given email & password. */
    public func authenticateWithPassword(
        email:String,
        password:String,
        resultHandler:ResultHandler) {
        
        // Attempting to authenticate with the Firebase API.
        FIRAuth.auth()?.signInWithEmail(email, password: password){
            (userOptional:FIRUser?, errorOptional:NSError?) -> Void in
        
            // Case 1. Success with user information
            if let user = userOptional {
                self.saveUserIdentifier(user.uid)
                resultHandler.onSuccessCallback?()
            }
            
            // Case 2. Failure with error information
            else {
                resultHandler.onErrorCallback?(errorOptional)
            }
        }
    }
    
    /** Creates a new account with the given email & password. */
    public func createAccount(
        email:String,
        password:String,
        resultHandler:ResultHandler) {
        
        // Attempting to create an account with the given email & password.
        FIRAuth.auth()?.createUserWithEmail(email, password: password){
            (userOptional:FIRUser?, errorOptional:NSError?) -> Void in
            
            // Case 1. Success with user information
            if let user = userOptional {
                self.saveUserIdentifier(user.uid)
                resultHandler.onSuccessCallback?()
            }
                
            // Case 2. Failure with error information
            else {
                resultHandler.onErrorCallback?(errorOptional)
            }
        }
    }
    
    /** Saves the uid of the authenticated user in App's preferences. */
    private func saveUserIdentifier(uid:String) {
        NSUserDefaults
            .standardUserDefaults()
            .setObject(uid, forKey: userIdentifierKey)
    }
}