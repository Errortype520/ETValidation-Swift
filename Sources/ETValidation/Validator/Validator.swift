//
//  ETValidationForm.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 8/6/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import UIKit

public enum ValidationResult {
    case success
    case failure( [ValidationError] )
}

fileprivate struct ValidatorItem {
    var control: AnyValidationProtocol
    var rules: [RuleProtocol]
}

open class Validator {
    
    fileprivate var items: [ValidatorItem] = []
    
    public init() { }
}

// MARK: Add / Remove Validators

extension Validator {
    
    public func removeRules( for control: AnyValidationProtocol ) {
        self.items = self.items.filter {
            return $0.control != control
        }
    }
    
    public func addRules( for control: AnyValidationProtocol, with rules: RuleProtocol...) {
        self.addRules(for: control, with: rules)
    }
    
    public func addRules( for control: AnyValidationProtocol, with rules: [RuleProtocol] ) {
        self.items.append(ValidatorItem(control: control, rules: rules))
    }
}

// MARK: Validate

extension Validator {
    
    public func validate(soft: Bool = false, complete: (ValidationResult) -> Void ) {
        
        var errors: [ValidationError] = []
        
        for item in self.items {
            let value = item.control.validationValue
            for rule in item.rules {
                
                if soft && rule.shouldIgnoreSoftValidation { continue }
                
                let didValidate = rule.validate(against: value)
                if !didValidate {
                    let error = ValidationError.failed(control: item.control, reason: rule.errorMessage)
                    errors.append(error)
                }
            }
        }
        
        switch errors.count {
        case 0:     complete(.success)
        default:    complete(.failure(errors))
        }
    }
}
