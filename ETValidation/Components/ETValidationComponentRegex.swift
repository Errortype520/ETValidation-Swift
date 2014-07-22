//
//  ETValidationComponentRegex.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 7/21/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import Foundation

class ETValidationComponentRegex : ETValidationComponent {
    
    // MARK: - Properties
    
    var pattern : String!
    
    // MARK: - Instance Methods
    
    /**
    *  Validation component with regular expression for validation.
    *
    *  @param delegate The control that owns this component
    *  @param valKey   The key path for the value to evaluate
    *  @param pattern  The regular expression pattern
    *
    *  @return Validation component requiring regex
    */
    init(delegate: ETValidationProtocol, validationKey: String, pattern:String) {
        super.init(delegate: delegate, validationKey: validationKey)
        self.pattern = pattern
    }
    
    /**
    *  Run component validation, and return nil or any errors found.
    *
    *  @return ETValidationError or nil
    */
    override func validate() -> ETValidationError? {
        
        // See if super validation generated an error which should be resolved first
        if let superError:ETValidationError = super.validate() { return superError }
        
        // Get the value using the keypath
        let rawValue:AnyObject! = (self.delegate as AnyObject).valueForKeyPath(self.valKey)
        // Check if raw value is a Boolean
        if ( rawValue is String ) {
            // Return an error as raw value should be a boolean
            return ETValidationError(control: self.delegate, message: "Regex Validation requires value to be string.")
        }

        // TODO: Test REGEX
        
        return nil
    }
    
}