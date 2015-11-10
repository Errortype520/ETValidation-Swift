//
//  ETValidationComponentBoolean.swift
//  ETValidation
//
//  Copyright (c) 2015 Joe Burgess
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

public class ETValidationComponentMatch<T where T:Equatable> : ETValidationComponent {
    
    // MARK: - Properties
    
    public var matchControl: ETValidationProtocol
    
    
    // MARK: - Instance methods
    
    /**
    *  Base validation component with delegate and key path.
    *
    *  @param delegate The control that owns this component
    *  @param valKey   The key path with the value to evaluate
    *
    *  @return Validation Component
    */
    public init (delegate: ETValidationProtocol, validationKey: String, matchControl: ETValidationProtocol, message: String = "Component does not match value.") {
        self.matchControl = matchControl
        super.init(delegate: delegate, validationKey: validationKey, message:message)
    }
    
    /**
     *  Run component validation, and return nil or any errors found.
     *
     *  @return ETValidationError or nil
     */
    public override func validate() -> [ETValidationError] {
        
        var errors = super.validate()
        
        guard let value = (self.delegate as AnyObject).valueForKeyPath(self.valKey) as? T,
                  value2 = (self.matchControl as AnyObject).valueForKeyPath(self.valKey) as? T else {
            errors.append( ETValidationError(control: self.delegate, message: "Match Control COmpotent failed to get value.") )
            return errors
        }
        
        if value != value2 { errors.append(ETValidationError(control: self.delegate, message: self.message) ) }
        
        return errors
    }
}