//
//  FormValidationUtil.swift
//  Team_India
//
//  Created by Josh Quaid on 3/8/22.
//

import Foundation
import UIKit

class FormValidationUtil {

    // Verifies that new passwords match in the registration page
    static func doPasswordsMatch(password1 : String, password2 : String) -> Bool {
        password1 == password2 ? true : false
    }
    
    // Verifies that the password created in the registration page meets complexity requirements
    static func isPasswordComplex(password : String) -> Bool {
        
        // Set up an NSPredicate with a regex to check for minimum 8 character password with a special character, uppercase, lowercase and/or number
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",
                                        "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return passwordCheck.evaluate(with: password)
    }
    
    // Verifies that the email address is formatted properly. This is not exhaustive, it's a precheck before sending to the authentication server for true verification
    static func isEmailFormatted(emailField : String) -> Bool {
        // Make a range for the emailField String
        let range = NSMakeRange(0, NSString(string: emailField).length)
        
        // Set up the NSDataDetector to check the email field
        guard
            let dataDetector = try? NSDataDetector(types: NSTextCheckingResult
                                                    .CheckingType
                                                    .link
                                                    .rawValue) else { return false }
        
        // Get all matches in the emailField that match the dataDetector specifications
        let matches = dataDetector.matches(in: emailField,
                                           options: [],
                                           range: range)
        
        // If there is a match, and the match has "mailto:" prepended, it's a good email
        if matches.count == 1 &&
           matches.first?.url?.absoluteString.contains("mailto:") == true {
            return true
        }
        
        return false
        
    }
}
