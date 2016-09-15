//
//  ETValidationComponent.swift
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

open class ETValidationComponent {
    
    // MARK: - Properties
    
    open var delegate : ETValidationProtocol
    open var valKey:  String
    open var message: String
    
    open var isValid: Bool {
        return (self.validate().count < 1)
    }
    
    // MARK: - Instance methods
    
    /**
    *  Base validation component with delegate and key path.
    *
    *  @param delegate The control that owns this component
    *  @param valKey   The key path with the value to evaluate
    *
    *  @return Validation Component
    */
    public init (delegate: ETValidationProtocol, validationKey:String, message:String = "") {
        self.delegate = delegate
        self.valKey = validationKey
        self.message = message
    }
    
    /**
    *  Run component validation, and return nil or any errors found.
    *
    *  @return ETValidationError or nil
    */
    open func validate() -> [ETValidationError] {
        // Passed all validation, no error generated
        return [ETValidationError]()
    }
}
