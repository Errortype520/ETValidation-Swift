//
//  ExactLengthRule.swift
//  ETValidation
//
//  Created by Joe Burgess on 12/23/20.
//

import Foundation

class ExactLengthRule: RuleProtocol {
    
    // MARK: - Properties
    public var requiredLengths: [Int] = [0]
    
    public var shouldIgnoreSoftValidation: Bool = false
    
    public lazy var errorMessage: String = {
        return self.defaultErrorMessage
    }()
    
    internal var defaultErrorMessage: String {
        switch self.requiredLengths.count {
        case 0: return "Exact Length Rule not met"
        case 1: return "Must be \(self.requiredLengths.first!) characters"
        case 2...Int.max:
            var requiredLengths = self.requiredLengths
            let last = requiredLengths.removeLast()
            return "Must be \( requiredLengths.map{String($0)}.joined(separator: ", ") ) or \(last) characters"
        default: fatalError("Out of range")
        }
    }
    
    public init(requiredLengths: [Int]) {
        self.requiredLengths = requiredLengths
    }
    
    convenience init(requiredLengths: Int...) {
        self.init(requiredLengths: requiredLengths)
    }
    
    public func validate(against: String) -> Bool {
        
        guard self.requiredLengths.count > 0 else { return true }
        
        return self.requiredLengths.contains(against.count)
    }
}
