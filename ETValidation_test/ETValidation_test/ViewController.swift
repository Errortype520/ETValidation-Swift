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

var sharedObserverSelector : Selector = "validationComponents"
extension UIView : ETValidationProtocol {
    public var validationComponents : Array<ETValidationComponent> {
        get { return objc_getAssociatedObject(self, &sharedObserverSelector) as! Array<ETValidationComponent> }
        set { objc_setAssociatedObject(self, &sharedObserverSelector, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


class ViewController: UIViewController {
    
    // MARK - Form 
    
    var form:ETValidationForm?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txtCharacterLimit: UITextField?
    @IBOutlet weak var txtPasword: UITextField?
    @IBOutlet weak var txtEmail: UITextField?
    
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
        guard let txtCharacterLimit = self.txtCharacterLimit, txtEmail = self.txtEmail, txtPasword = self.txtPasword else { return }
        
        // Add a character limit validation component to the character limit text field
        let txtCharacterLimitComponent:ETValidationComponent = ETValidationComponentCharacterLimit(delegate:txtCharacterLimit, validationKey:"text", minCharacters: 1, maxCharacters: 10)
        txtCharacterLimit.validationComponents = [txtCharacterLimitComponent]
        
        // Add a email validation component to the email text field
        let txtEmailComponent:ETValidationComponent = ETValidationComponentEmail(delegate: txtEmail, validationKey: "text")
        txtEmail.validationComponents = [txtEmailComponent]
        
        // Add password validation component to the password text field
        let txtPasswordComponent:ETValidationComponent = ETValidationComponentPassword(delegate: txtPasword, validationKey: "text")
        txtPasword.validationComponents = [txtPasswordComponent]
        
        // Create a form with that will validate these components
        self.form = ETValidationForm(controls: txtCharacterLimit, txtEmail, txtPasword)
        
        // Handle form validation
        self.handleTestFormValidation(nil)
    }
    
    @IBAction func handleTestFormValidation(sender:UIButton?) {
        
        // Validate the form
        self.form?.validateForm({ () in
            print("Form Validation Success!")
        }, failure: { (errors) in
            print("Form Validation Failure!")
            for error in errors {
                print("Control: \(error.control)  | Message:  \(error.message)")
            }
        })
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
        
        let testLabel:UILabel = UILabel(frame: CGRectZero)
        let testLabel2:UILabel = UILabel(frame: CGRectZero)
        
        let component:ETValidationComponent = ETValidationComponentMatch<String>(delegate: testLabel, validationKey: "text", matchControl: testLabel2)
        testLabel.validationComponents = [component]
        
        print("+------------------------------------------")
        print(" Component Match")
        print("+------------------------------------------")
        
        testLabel.text  = "One"
        testLabel2.text = "Two"
        print("Text: [One, Two]  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel2.text = "One"
        print("Text: [One, One]  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        
        print("+------------------------------------------")
    }
    
    func testComponentBoolean() {
    
        let testSwitch:UISwitch = UISwitch()
        let component:ETValidationComponent = ETValidationComponentBoolean(delegate: testSwitch, validationKey: "on", requiredBool: true)
        testSwitch.validationComponents = [component]
        
        print("+------------------------------------------")
        print(" Boolean (Required true)")
        print("+------------------------------------------")
        
        testSwitch.on = false
        print("Switch: OFF |  Validated: " + (( component.isValid ) ? "YES" : "NO") )
        testSwitch.on = true
        print("Switch: ON  |  Validated: " + (( component.isValid ) ? "YES" : "NO") )
        
        print("+------------------------------------------")
    }
    
    func testComponentPassword() {
        
        let testLabel:UILabel = UILabel(frame: CGRectZero)
        let component:ETValidationComponent = ETValidationComponentPassword(delegate: testLabel, validationKey: "text")
        testLabel.validationComponents = [component]
        
        print("+------------------------------------------")
        print(" Password Validation")
        print("+------------------------------------------")
        
        testLabel.text = ""
        print("Text: [empty]  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test1"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test1 #"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "test1#"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test##"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test1#"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        
        
        print("+------------------------------------------")
    }
    
    func testComponentEmail() {
        
        let testLabel:UILabel = UILabel(frame: CGRectZero)
        let component:ETValidationComponent = ETValidationComponentEmail(delegate: testLabel, validationKey: "text")
        testLabel.validationComponents = [component]
        
        print("+------------------------------------------")
        print(" Email Validation")
        print("+------------------------------------------")
        
        testLabel.text = ""
        print("Text: [empty]  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "test@test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "test@test.com"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        
        print("+------------------------------------------")
    }
    
    func testComponentRegex() {
        
        let testLabel:UILabel = UILabel(frame: CGRectZero)
        let component:ETValidationComponent = ETValidationComponentRegex(delegate: testLabel, validationKey: "text", pattern:"[a-zA-Z]+")
        testLabel.validationComponents = [component]
        
        print("+------------------------------------------")
        print(" Regex ([a-zA-Z]+)")
        print("+------------------------------------------")
        
        testLabel.text = ""
        print("Text: [empty]  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "#Bad characters"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        
        print("+------------------------------------------")
    }
    
    func testComponentCharLimit() {
        
        let testLabel:UILabel = UILabel(frame: CGRectZero)
        let component:ETValidationComponent = ETValidationComponentCharacterLimit(delegate: testLabel, validationKey: "text", minCharacters: 1, maxCharacters: 10)
        testLabel.validationComponents = [component]
        
        print("+------------------------------------------")
        print(" Character Limit")
        print("+------------------------------------------")
        
        testLabel.text = ""
        print("Text: [empty]  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Text is too long"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        testLabel.text = "Test"
        print("Text: \(testLabel.text!)  |  Validated: " + ((component.isValid) ? "YES" : "NO") )
        
        print("+------------------------------------------")
        
    }
}

