//
//  ETValidationComponentEmail.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 7/26/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import Foundation

class ETValidationComponentEmail : ETValidationComponentRegex {
    
    override var pattern : String {
        set { print("Cannot change pattern on email component. Use Regex component instead.") }
        get {
                // Use RFC-2822 email validation
                // Xcode 6 beta 4 has a bug concatenating strings, this is a work around
                let emailPattern =  "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
                                    "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                                    "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                                    "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                                    "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                                    "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
                                    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            
                return  emailPattern
        }
    }
    
    
    required init (delegate: ETValidationProtocol, validationKey: String, message:String = "Not a valid email address") {
        super.init(delegate: delegate, validationKey: validationKey, message:message)
    }
}