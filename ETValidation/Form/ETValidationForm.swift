//
//  ETValidationForm.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 8/6/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import UIKit

class ETValidationForm<T where T:ETValidationProtocol> : NSObject {
    
    // MARK: Properties
    
    var validationControls : Array<T>               // The controls that require validation
    var validationErrors : Array<ETValidationError> // The errors reported the last time the form tried to validate
    
    
    
    // MARK: Initialization
    
    /**
    *  Create validation form with list of controls (Objects that follow ETValidationProtocol).
    *
    *  @param firstControl List of controls (nil termination)
    *
    *  @return Validation form
    */
    convenience init (controls:T...) {
        self.init(controls:controls)
    }
    
    /**
    *  Create validation form with array of controls (Objects that follow ETValidationProtocol).
    *
    *  @param controls Array of controls to build form
    *
    *  @return Validation Form
    */
    init (controls:Array<T>) {
        self.validationControls = controls
        self.validationErrors = []
    }
    
    
    // MARK: - Add / Remove Controls
    
    func addControl(control:T) {
        self.validationControls.append(control);
    }
    
    // TODO: Swift limitation on array of protocol type prevents easily removing controls.
    func removeControl(control:T) {
//        if let x = find(self.validationControls, control) {
//            self.validationControls.removeAtIndex(x)
//        }
    }
    
    // MARK: - Validate Form With Success
    
    func validateForm(success:(Void) -> Void, failure:(Array<ETValidationError>) -> Void) {
        
        // Remove all items from the Validation errors array
        self.validationErrors.removeAll(keepCapacity:false)
        
        // Validate each component in validation controls
        for control in self.validationControls {
            // Get the validation components from the control
            var validationComponents = control.validationComponents
            // Validate all components in control
            for component in validationComponents {
                // Get the error (if any) from validation
                var error = component.validate()
                // if there is an error in validation
                if ((error) != nil) {
                    // Append the error to our validation errors
                    self.validationErrors.append(error!)
                }
            }
        }
        
        // Do callback based on validation
        if (self.validationErrors.isEmpty)  { success()
        } else { failure(self.validationErrors) }
    }
}
