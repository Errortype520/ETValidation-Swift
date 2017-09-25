//
//  ViewController.swift
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

import UIKit

class ViewController: UIViewController {
    
    // MARK - Form 
    
    var validator = Validator()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txtCharacterLimit: UITextField!
    @IBOutlet weak var txtPasword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: - View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test individual component validation
        self.testValidation()
        
        // Test form validation using IBOutlets
        self.testFormValidation()
    }
    
    // MARK: - Form Validation (IBOutlets)
    
    func testFormValidation() {
        
    }
    
    @IBAction func handleTestFormValidation(_ sender:UIButton?) {
        
        // Validate the form
//        self.form?.validateForm({ () in
//            print("Form Validation Success!")
//        }, failure: { (errors) in
//            print("Form Validation Failure!")
//            for error in errors {
//                print("Control: \(String(describing: error.control))  | Message:  \(error.message)")
//            }
//        })
    }
    
    // MARK: - Individual Component Validation
    
    func testValidation() {
        self.testComponentCharLimit()
        self.testComponentRegex()
        self.testComponentEmail()
        self.testComponentPassword()
        self.testComponentBoolean()
        self.testComponentMatch()
    }
    
    func testComponentMatch() {
        
        let testLabel:UILabel = UILabel(frame: CGRect.zero)
        let testLabel2:UILabel = UILabel(frame: CGRect.zero)
        
        let validator = Validator()
        let rule = MatchRule(match: testLabel2)
        validator.addRules(for: testLabel, with: [rule])
        
        print("+------------------------------------------")
        print(" Component Match")
        print("+------------------------------------------")
        
        func validate(_ test:String) {
            validator.validate() { result in
                switch result {
                case .success: print(test + "  |  Validated: YES")
                case .failure: print(test + "  |  Validated: NO")
                }
            }
        }
        
        testLabel.text  = "One"
        testLabel2.text = "Two"
        
        validate("Text: [One, Two]")
        
        testLabel2.text = "One"
        
        validate("Text: [One, One]")
        
        testLabel2.text = "Three"
        
        validate("Text: [One, Three]")
        
        validator.removeRules(for: testLabel)
        validator.removeRules(for: testLabel) // Test removing control that is no longer there
        
        validate("Text: [One, Three] - Removed Rule")
        
        print("+------------------------------------------")
    }
    
    func testComponentBoolean() {
    
        let testSwitch:UISwitch = UISwitch()
        
        let validator = Validator()
        let rule = BooleanRule(requiredValue: true)
        validator.addRules(for: testSwitch, with: [rule])
        
        print("+------------------------------------------")
        print(" Boolean (Required true)")
        print("+------------------------------------------")
        
        func validate(_ test:String) {
            validator.validate() { result in
                switch result {
                case .success: print(test + "  |  Validated: YES")
                case .failure: print(test + "  |  Validated: NO")
                }
            }
        }
        
        testSwitch.isOn = false
        
        validate("Switch: OFF")
        
        testSwitch.isOn = true
        
        validate("Switch: ON")
        
        print("+------------------------------------------")
    }
    
    func testComponentPassword() {
        
        let testLabel:UILabel = UILabel(frame: CGRect.zero)
        
        let validator = Validator()
        let rule = PasswordRule()
        validator.addRules(for: testLabel, with: [rule])

        print("+------------------------------------------")
        print(" Password Validation")
        print("+------------------------------------------")
        
        func validate(_ test:String) {
            validator.validate() { result in
                switch result {
                case .success: print(test + "  |  Validated: YES")
                case .failure: print(test + "  |  Validated: NO")
                }
            }
        }

        testLabel.text = ""
        validate("Text: [empty]")
        testLabel.text = "test"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "Test"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "Test"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "Test1"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "Test1 #"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "test1#"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "Test##"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "Test1#"
        validate("Text: \(testLabel.text!)")


        print("+------------------------------------------")
    }
    
    func testComponentEmail() {
        
        let testLabel:UILabel = UILabel(frame: CGRect.zero)
        
        let validator = Validator()
        let rule = EmailRule()
        validator.addRules(for: testLabel, with: [rule])

        print("+------------------------------------------")
        print(" Email Validation")
        print("+------------------------------------------")
        
        func validate(_ test:String) {
            validator.validate() { result in
                switch result {
                case .success: print(test + "  |  Validated: YES")
                case .failure: print(test + "  |  Validated: NO")
                }
            }
        }
        
        testLabel.text = nil
        validate("Text: [nil]")
        testLabel.text = "test"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "test@test"
        validate("Text: \(testLabel.text!)")
        testLabel.text = "test@test.com"
        validate("Text: \(testLabel.text!)")

        print("+------------------------------------------")
    }
    
    func testComponentRegex() {
        let testLabel:UILabel = UILabel(frame: CGRect.zero)
        
        let validator = Validator()
        let rule = RegexRule(pattern: "[a-zA-Z]+")
        validator.addRules(for: testLabel, with: [rule])

        print("+------------------------------------------")
        print(" Regex ([a-zA-Z]+)")
        print("+------------------------------------------")
        
        func validate(_ test:String) {
            validator.validate() { result in
                switch result {
                case .success: print(test + "  |  Validated: YES")
                case .failure: print(test + "  |  Validated: NO")
                }
            }
        }
        
        testLabel.text = ""
        
        validate("Text: [empty]")
        
        testLabel.text = "#Bad characters"
        
        validate("Text: \(testLabel.text!)")
        
        testLabel.text = "Test"
        
        validate("Text: \(testLabel.text!)")

        print("+------------------------------------------")
    }
    
    func testComponentCharLimit() {

        let testLabel:UILabel = UILabel(frame: CGRect.zero)
        
        let validator = Validator()
        let minRule = RequiredRule()
        let maxRule = MaxLengthRule(requiredLength: 10)
        validator.addRules(for: testLabel, with: [minRule, maxRule])
        
        print("+------------------------------------------")
        print(" Character Limit")
        print("+------------------------------------------")
        
        func validate(_ test:String) {
            validator.validate() { result in
                switch result {
                case .success: print(test + "  |  Validated: YES")
                case .failure: print(test + "  |  Validated: NO")
                }
            }
        }
        
        testLabel.text = ""
        
        validate("Text: [empty]")
        
        testLabel.text = "Text is too long"
        
        validate("Text: \(testLabel.text!)")
        
        testLabel.text = "Test"
        
        validate("Text: \(testLabel.text!)")

        print("+------------------------------------------")
        
    }
}

