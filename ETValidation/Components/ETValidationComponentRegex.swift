//
//  ETValidationComponentRegex.swift
//  ETValidation
//
//  Copyright (c) 2014 Joe Burgess
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
    init <T where T : ETValidationProtocol>(delegate: T, validationKey: String, pattern:String = "") {
        self.pattern = pattern
        super.init(delegate: delegate, validationKey: validationKey)
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
        if ( !(rawValue is String) ) {
            // Return an error as raw value should be a boolean
            return ETValidationError(control: self.delegate, message: "Regex Validation requires value to be string.")
        }
        
        // Create the NSPredicate
        let value:String = rawValue as! String;
        let regex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", self.pattern);
        // Validate the regex component
        if ( !regex.evaluateWithObject(value) ) {
            return ETValidationError(control: self.delegate, message: "Does not meet regular expression.");
        }
        
        // Passed validation
        return nil
    }
    
}