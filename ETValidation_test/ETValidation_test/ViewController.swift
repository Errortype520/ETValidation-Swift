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
    
    var form:ETValidationForm<ETValidationProtocol>!
    
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
        
        // Add a character limit validation component to the character limit text field
        var txtCharacterLimitComponent:ETValidationComponent = ETValidationComponentCharacterLimit(delegate:self.txtCharacterLimit, validationKey:"text", minCharacters: 1, maxCharacters: 10)
        self.txtCharacterLimit.validationComponents = [txtCharacterLimitComponent]
        
        // Add a email validation component to the email text field
        var txtEmailComponent:ETValidationComponent = ETValidationComponentEmail(delegate: self.txtEmail, validationKey: "text")
        self.txtEmail.validationComponents = [txtEmailComponent]
        
        // Add password validation component to the password text field
        var txtPasswordComponent:ETValidationComponent = ETValidationComponentPassword(delegate: self.txtPasword, validationKey: "text")
        self.txtPasword.validationComponents = [txtPasswordComponent]
        
        // Create a form with that will validate these components
        self.form = ETValidationForm(controls: txtCharacterLimit, txtEmail, txtPasword)
        
        // Handle form validation
        self.handleTestFormValidation(nil)
    }
    
    @IBAction func handleTestFormValidation(sender:UIButton?) {
        
        // Validate the form
        self.form.validateForm({ () in
            println("Form Validation Success!")
        }, failure: { (errors) in
            println("Form Validation Failure!")
            for error in errors {
                println("Control: \(error.control)  | Message:  \(error.message)")
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
    }
    
    func testComponentBoolean() {
    
        var testSwitch:UISwitch = UISwitch()
        var component:ETValidationComponent = ETValidationComponentBoolean(delegate: testSwitch, validationKey: "on", requiredBool: true)
        testSwitch.validationComponents = [component]
        
        println("+------------------------------------------")
        println(" Boolean (Required true)")
        println("+------------------------------------------")
        
        testSwitch.on = false
        println("Switch: OFF |  Validated: " + (( component.validate() != nil ) ? "NO" : "YES") )
        testSwitch.on = true
        println("Switch: ON  |  Validated: " + (( component.validate() != nil ) ? "NO" : "YES") )
        
        println("+------------------------------------------")
    }
    
    func testComponentPassword() {
        
        var testLabel:UILabel = UILabel(frame: CGRectZero)
        var component:ETValidationComponent = ETValidationComponentPassword(delegate: testLabel, validationKey: "text")
        testLabel.validationComponents = [component]
        
        println("+------------------------------------------")
        println(" Password Validation")
        println("+------------------------------------------")
        
        testLabel.text = ""
        println("Text: [empty]  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test1"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test1 #"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "test1#"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test##"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test1#"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        
        
        println("+------------------------------------------")
    }
    
    func testComponentEmail() {
        
        var testLabel:UILabel = UILabel(frame: CGRectZero)
        var component:ETValidationComponent = ETValidationComponentEmail(delegate: testLabel, validationKey: "text")
        testLabel.validationComponents = [component]
        
        println("+------------------------------------------")
        println(" Email Validation")
        println("+------------------------------------------")
        
        testLabel.text = ""
        println("Text: [empty]  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "test@test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "test@test.com"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        
        println("+------------------------------------------")
    }
    
    func testComponentRegex() {
        
        var testLabel:UILabel = UILabel(frame: CGRectZero)
        var component:ETValidationComponent = ETValidationComponentRegex(delegate: testLabel, validationKey: "text", pattern:"[a-zA-Z]+")
        testLabel.validationComponents = [component]
        
        println("+------------------------------------------")
        println(" Regex ([a-zA-Z]+)")
        println("+------------------------------------------")
        
        testLabel.text = ""
        println("Text: [empty]  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "#Bad characters"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        
        println("+------------------------------------------")
    }
    
    func testComponentCharLimit() {
        
        var testLabel:UILabel = UILabel(frame: CGRectZero)
        var component:ETValidationComponent = ETValidationComponentCharacterLimit(delegate: testLabel, validationKey: "text", minCharacters: 1, maxCharacters: 10)
        testLabel.validationComponents = [component]
        
        println("+------------------------------------------")
        println(" Character Limit")
        println("+------------------------------------------")
        
        testLabel.text = ""
        println("Text: [empty]  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Text is too long"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        testLabel.text = "Test"
        println("Text: \(testLabel.text)  |  Validated: " + ((component.validate() != nil) ? "NO" : "YES") )
        
        println("+------------------------------------------")
        
    }
}

