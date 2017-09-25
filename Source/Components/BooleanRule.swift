//
//  BooleanRule.swift
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

open class BooleanRule: RuleProtocol {
    
    // MARK: - Properties
    
    public var requiredBool: Bool
    
    public var errorMessage: String {
        get { return self._errorMessage ?? defaultErrorMessage }
        set { self._errorMessage = newValue }
    }; private var _errorMessage: String?
    private var defaultErrorMessage: String {
        return "Must be \(requiredBool)"
    }
    
    required public init(requiredValue: Bool = true) {
        self.requiredBool = requiredValue
    }
    
    public func validate(against: String) -> Bool {
        let against: Bool = !against.isEmpty
        
        return self.requiredBool == against
    }
}
