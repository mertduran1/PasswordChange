//
//  ViewControllerTests.swift
//  PWTests
//
//  Created by Mert Duran on 21.11.2022.
//

import XCTest

@testable import PW

class ViewControllerTests_NewPassword_Validation: XCTestCase {
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
        
    }
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Enter Your Password")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordText = "₺"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Enter valid characters(no spaces)")
    }
    func testCriteriaNotMet() throws {
        vc.newPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Your password must meet the requirements!")
    }
    
    func testValidPassword() throws {
        vc.newPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "")
    }
}

class ViewControllerTests_Confirm_Password_Validation: XCTestCase {
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password.")
    }
    func testPasswordNotMatch() throws {
        vc.newPasswordText = "12345"
        vc.confirmPasswordText = "1234"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match")
    }
    
    func testPasswordsMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
        
    }
}

class ViewControllerTests_Show_Alert: XCTestCase {
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "12345A"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertNotNil(vc.alert)
    }
    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertNil(vc.alert)
    }
}
