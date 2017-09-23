//
//  ValidationProtocol.swift
//  Validation
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


import UIKit

public typealias AnyValidationProtocol = AnyObject & ValidationProtocol

public protocol ValidationProtocol: class {
    
    // Due to PAT's being so restrictive, we are going to avoid using an associatedtype for now. When
    // Swift supports Existentials and makes it so we do not need type erasures to support a collection
    // of Pats we can revisit this.
    
    // https://www.youtube.com/watch?v=XWoNjiSPqI8
    // https://medium.com/@kahseng.lee123/accomplishing-dynamic-dispatch-on-pats-protocol-with-associated-types-b29d1242e939
    //associatedtype T: Equatable
    //
    //var validationValue: T { get }
    
    var validationValue: String { get }
}

func ==(lhs:AnyValidationProtocol, rhs:AnyValidationProtocol) -> Bool {
    
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

func !=(lhs:AnyValidationProtocol, rhs:AnyValidationProtocol) -> Bool {
    
    return ObjectIdentifier(lhs) != ObjectIdentifier(rhs)
}


extension UITextField: ValidationProtocol {
    
    public var validationValue: String {
        return self.text ?? ""
    }
}

extension UILabel: ValidationProtocol {
    
    public var validationValue: String {
        return self.text ?? ""
    }
}

extension UITextView: ValidationProtocol {
    
    public var validationValue: String {
        return self.text ?? ""
    }
}

extension UISwitch: ValidationProtocol {
    
    public var validationValue: String {
        return self.isOn ? "yes" : ""
    }
}
