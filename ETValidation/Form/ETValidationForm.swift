//
//  ETValidationForm.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 8/6/14.
//  Copyright (c) 2014 Joseph Burgess. All rights reserved.
//

import UIKit

class ETValidationForm : NSObject {
    
    // MARK: Properties
    
    var validationControls : Array<ETValidationProtocol>       // The controls that require validation
    var validationErrors : Array<AnyObject>                    // The errors reported the last time the form tried to validate
    
    
    
    // MARK: Initialization
    
    /**
    *  Create validation form with list of controls (Objects that follow ETValidationProtocol).
    *
    *  @param firstControl List of controls (nil termination)
    *
    *  @return Validation form
    */
    convenience init <T where T : ETValidationProtocol>(controls:T...) {
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
    }
    
    
    // MARK: - Add / Remove Controls
    
    func addCOntrol(control:ETValidationProtocol) {
        self.validationControls.append(control);
    }
    
    func removeControl(control:ETValidationProtocol) {
        self.validationControls = self.validationControls.filter({ ($0 as ETValidati) != control});
    }
}
