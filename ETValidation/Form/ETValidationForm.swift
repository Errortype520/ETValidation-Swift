//
//  ETValidationForm.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 8/6/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import UIKit

class ETValidationForm {
    
    // MARK: Properties
    
    var validationControls :    [ETValidationProtocol]    // The controls that require validation
    var validationErrors :      [ETValidationError]     // The errors reported the last time the form tried to validate
    
    
    
    // MARK: Initialization
    
    /**
    *  Create validation form with list of controls (Objects that follow ETValidationProtocol).
    *
    *  @param firstControl List of controls (nil termination)
    *
    *  @return Validation form
    */
    convenience init (controls:ETValidationProtocol...) {
        self.init(controls:controls)
    }
    
    /**
    *  Create validation form with array of controls (Objects that follow ETValidationProtocol).
    *
    *  @param controls Array of controls to build form
    *
    *  @return Validation Form
    */
    init (controls:Array<ETValidationProtocol>) {
        self.validationControls = controls
        self.validationErrors = []
    }
    
    
    // MARK: - Add / Remove Controls
    
    func addControl(control:ETValidationProtocol) {
        self.validationControls.append(control)
    }
    
    func removeControl(control:ETValidationProtocol) {
        for i in 0 ... self.validationErrors.count {
            if self.validationControls[i] === control {
                self.validationControls.removeAtIndex(i)
                return
            }
        }
    }
    
    // MARK: - Validate Form With Success
    
    func validateForm(success:(Void) -> Void, failure:(Array<ETValidationError>) -> Void) {
        
        // Remove all items from the Validation errors array
        self.validationErrors.removeAll(keepCapacity:false)
        
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
