//
//  ETValidationComponentBoolean.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 7/20/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import Foundation

class ETValidationComponentBoolean : ETValidationComponent {
    
    // MARK: - Properties
    
    var requiredBool : Bool!
    
    
    // MARK: - Instance methods
    
    /**
    *  Base validation component with delegate and key path.
    *
    *  @param delegate The control that owns this component
    *  @param valKey   The key path with the value to evaluate
    *
    *  @return Validation Component
    */
    init (delegate:protocol<ETValidationProtocol>, validationKey:String, requiredBool:Bool) {
        super.init(delegate: delegate, validationKey: validationKey)
        self.requiredBool = requiredBool
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
        if ( rawValue is Bool ) {
            // Return an error as raw value should be a boolean
            return ETValidationError(control: self.delegate, message: "Bool evaluation requires BOOL value.")
        }
        
        // Passed initial validation, let's see if we match our required value
        var actualBool:Bool = rawValue as Bool
        // if the actual bool does not match required value
        if (actualBool != self.requiredBool) {
            return ETValidationError(control: self.delegate, message: "Boolean does not meet required value.")
        }
        
        // No errors found
        return nil
    }
}