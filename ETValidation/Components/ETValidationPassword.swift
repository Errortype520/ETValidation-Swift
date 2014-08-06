//
//  ETValidationPassword.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 8/5/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import Foundation

class ETValidationPassword : ETValidationComponentRegex {
    
    override var pattern : String! {
        set { println("Cannot change pattern on password component. Use Regex component instead.") }
        get {
            // ^                 # start-of-string
            // (?=.*[0-9])       # a digit must occur at least once
            // (?=.*[a-z])       # a lower case letter must occur at least once
            // (?=.*[A-Z])       # an upper case letter must occur at least once
            // (?=.*[@#$%^&+=])  # a special character must occur at least once
            // (?=\S+$)          # no whitespace allowed in the entire string
            // .{6,}             # at least 6 characters
            // $                 # end-of-string
            return "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!?])(?=\\S+$).{6,}$"
        }
    }
    
    /**
    *  Validation component to validate passwords
    *
    *  @param delegate The control that owns this component
    *  @param valKey   The key path with the value to evaluate
    *
    *  @return Validation Component
    */
    init <T where T : ETValidationProtocol>(delegate: T, validationKey:String) {
        super.init(delegate: delegate, validationKey: validationKey)
    }
    
}