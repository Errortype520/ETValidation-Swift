//
//  ETValidationComponentEmail.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 7/26/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import Foundation

class ETValidationComponentEmail : ETValidationComponentRegex {
    
    override var pattern : String! {
        set { println("Cannot change pattern on email component. Use Regex component instead.") }
        get {
                // Use RFC-2822 email validation
                // Xcode 6 beta 4 has a bug concatenating strings, this is a work around
                var emailPattern =  "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
                emailPattern    +=  "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
                emailPattern    +=  "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
                emailPattern    +=  "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
                emailPattern    +=  "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
                emailPattern    +=  "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
                emailPattern    +=  "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
                
                return  emailPattern
        }
    }
    
    /**
    *  Validation component to validate email address
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