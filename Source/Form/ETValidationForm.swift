//
//  ETValidationForm.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 8/6/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import UIKit

open class ETValidationForm {
    
    // MARK: Properties
    
    open var validationControls :    [ETValidationProtocol]    // The controls that require validation
    open var validationErrors :      [ETValidationError]     // The errors reported the last time the form tried to validate
    
    
    
    // MARK: Initialization
    
    /**
    *  Create validation form with list of controls (Objects that follow ETValidationProtocol).
    *
    *  @param firstControl List of controls (nil termination)
    *
    *  @return Validation form
    */
    public convenience init (controls:ETValidationProtocol...) {
        self.init(controls:controls)
    }
    
    /**
    *  Create validation form with array of controls (Objects that follow ETValidationProtocol).
    *
    *  @param controls Array of controls to build form
    *
    *  @return Validation Form
    */
    public init (controls:Array<ETValidationProtocol>) {
        self.validationControls = controls
        self.validationErrors = []
    }
    
    
    // MARK: - Add / Remove Controls
    
    open func addControl(_ control:ETValidationProtocol) {
        self.validationControls.append(control)
    }
    
    open func removeControl(_ control:ETValidationProtocol) {
        for (index, cntrl) in self.validationControls.enumerated() {
            
            if cntrl === control {
                self.validationControls.remove(at: index)
                return
            }
        }
    }
    
    // MARK: - Validate Form With Success
    
    open func validateForm(_ success:(Void) -> Void, failure:(Array<ETValidationError>) -> Void) {
        
        // Remove all items from the Validation errors array
        self.validationErrors.removeAll(keepingCapacity:false)
        
        // Validate each component in validation controls
        for control in self.validationControls {
            // Get the validation components from the control
            let validationComponents = control.validationComponents
            // Validate all components in control
            for component in validationComponents {
                // Get the error (if any) from validation
                let errors = component.validate()
                // if there is an error in validation
                if (errors.count > 0) {
                    // Append the errors to our validation errors
                    self.validationErrors += errors
                }
            }
        }
        
        // Do callback based on validation
        if (self.validationErrors.isEmpty)  { success()
        } else { failure(self.validationErrors) }
    }
}
