//
//  ETValidationComponentCharacterLimit.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 7/21/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import Foundation

class ETValidationComponentCharacterLimit : ETValidationComponent {
    
    // MARK: - Properties
    
    var minCharacters : Int = 0
    var maxCharacters : Int = Int.max
    
    // MARK: - Instance Methods
    
    /**
    *  Validation component with a minimum and maxium number of characters allowed.
    *
    *  @param delegate Component owner (control)
    *  @param valKey   Key path to validate on ("text")
    *  @param min      Minimum number of characters allowed
    *  @param max      Maximum number of characters allowed
    *
    *  @return Character Limit Validation component
    */
    init(delegate: ETValidationProtocol, validationKey: String, minCharacters : Int = 0, maxCharacters : Int = Int.max) {
        super.init(delegate: delegate, validationKey: validationKey);
        self.minCharacters = minCharacters;
        self.maxCharacters = maxCharacters;
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
            return ETValidationError(control: self.delegate, message: "Character Limit Validation requires value to be string.")
        }
        
        // The number of characters in our string
        var numCharacters:Int = countElements(rawValue as String);
        
        // If the number of characters is out of range
        if (numCharacters < self.minCharacters || numCharacters > self.maxCharacters) {
            return ETValidationError(control: self.delegate, message: "Does not meet character limit.");
        }
        
        // Passed validation
        return nil
    }
}