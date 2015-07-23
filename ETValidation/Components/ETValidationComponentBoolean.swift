//
//  ETValidationComponentBoolean.swift
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

class ETValidationComponentBoolean : ETValidationComponent {
    
    // MARK: - Properties
    
    var requiredBool : Bool
    
    
    // MARK: - Instance methods
    
    /**
    *  Base validation component with delegate and key path.
    *
    *  @param delegate The control that owns this component
    *  @param valKey   The key path with the value to evaluate
    *
    *  @return Validation Component
    */
    init (delegate: ETValidationProtocol, validationKey:String, requiredBool:Bool, message:String = "Boolean does not meet required value.") {
        self.requiredBool = requiredBool
        super.init(delegate: delegate, validationKey: validationKey, message:message)
    }
    
    /**
    *  Run component validation, and return nil or any errors found.
    *
    *  @return ETValidationError or nil
    */
    override func validate() -> [ETValidationError] {
        
        var errors = super.validate()
        
        guard let value = (self.delegate as AnyObject).valueForKeyPath(self.valKey) as? Bool else {
            errors.append( ETValidationError(control: self.delegate, message: "Bool evaluation requires BOOL value.") )
            return errors
        }
        
        if value != self.requiredBool {
            errors.append(ETValidationError(control: self.delegate, message: self.message) )
        }
        
        return errors
    }
}