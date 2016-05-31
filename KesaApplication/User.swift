import Foundation

/**
 Representation of a user in KesaApplication
 
 @author hongil
 */
public class User {
    var uid: String
    var firstName: String
    var lastName: String
    var program: String
    var mobile: String
    var profileImage: String
    var email: String
    var admissionYear: Int
    var isExecutive: Bool
    var isContactPublic: Bool
    
    init(uid: String,
         firstName: String,
         lastName: String,
         program: String,
         mobile: String,
         profileImage: String,
         email: String,
         admissionYear: Int,
         isExecutive: Bool,
         isContactPublic: Bool) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.program = program
        self.mobile = mobile
        self.profileImage = profileImage
        self.email = email
        self.admissionYear = admissionYear
        self.isExecutive = isExecutive
        self.isContactPublic = isContactPublic
    }
    
    /** 
     Converts the admission year to a String with the last two digits,
     <secondLastDigit>T<lastDigit>
     */
    public func getAdmissionYearToString() -> String {
        let graduationYear = admissionYear + 4
        let lastDigit = graduationYear % 10
        let secondLastDigit = (graduationYear / 10) % 10
        
        return "\(secondLastDigit)T\(lastDigit)"
    }
    
    public func getFullName() -> String {
        return firstName + " " + lastName
    }
}