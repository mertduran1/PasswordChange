//
//  PasswordStatusViewTests.swift
//  PWTests
//
//  Created by Mert Duran on 20.11.2022.
//

import XCTest

@testable import PW

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {
    var statusView : PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp(){
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true
    }
    
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)  
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {
    var statusView: PasswordStatusView!
    let validPassword = "1234578Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false
    }
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
    }
}

/*
class PasswordStatusViewTests_ShowMetCriterias: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "1234578Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false
    }
    
    func testMetCriteria() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.validate(validPassword))
    }
    func testNonMetCriteria() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.validate(tooShort))
    }
}
*/

class PasswordStatusViewTests_Validate_Three_Of_Four: XCTestCase {
    var statusView: PasswordStatusView!
    let twoOfFour = "12345678A"
    let threeOfFour = "12345678Aa"
    let fourOfFour = "12345678Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }
    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
    }
    func testfourOfFour() throws {
        XCTAssertTrue(statusView.validate(fourOfFour))
    }
}

