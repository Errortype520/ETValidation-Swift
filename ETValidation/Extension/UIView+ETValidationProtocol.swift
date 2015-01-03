//
//  UIView+ETValidationProtocol.swift
//  ETValidation_test
//
//  Created by Joseph Burgess on 1/2/15.
//  Copyright (c) 2015 Joseph Burgess. All rights reserved.
//

import UIKit

var sharedObserverSelector : Selector = "validationComponents"
extension UIView : ETValidationProtocol {
    var validationComponents : Array<ETValidationComponent> {
        get { return objc_getAssociatedObject(self, &sharedObserverSelector) as Array<ETValidationComponent> }
        set { objc_setAssociatedObject(self, &sharedObserverSelector, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC)) }
    }
}