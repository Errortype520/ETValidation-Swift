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

public class ETValidationComponentRegex : ETValidationComponent {
    
    // MARK: - Properties
    
    public var pattern : String
    
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
    public init (delegate: ETValidationProtocol, validationKey: String, pattern:String = "", message:String = "Does not meet regular expression.") {
        self.pattern = pattern
        super.init(delegate: delegate, validationKey: validationKey, message:message)
    }
    
    /**
    *  Run component validation, and return nil or any errors found.
    *
    *  @return ETValidationError or nil
    */
    public override func validate() -> [ETValidationError] {
        
        var errors = super.validate()
        
        guard let value = (self.delegate as AnyObject).valueForKeyPath(self.valKey) as? String else {
            errors.append( ETValidationError(control: self.delegate, message: "Regex Validation requires value to be string.") )
            return errors
        }
        
        // Create the NSPredicate
        let regex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", self.pattern)
        
        if !regex.evaluateWithObject(value) {
            errors.append(ETValidationError(control: self.delegate, message: self.message) )
        }
        
        return errors
    }
    
}