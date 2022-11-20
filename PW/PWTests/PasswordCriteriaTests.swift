//
//  PasswordCriteriaTests.swift
//  PWTests
//
//  Created by Mert Duran on 20.11.2022.
//

import XCTest

@testable import PW

class PasswordLengthCriteriaTests: XCTestCase {
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567")) // 7
    }
    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890123")) //-< 33 değer
    }
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678")) // 8
    }
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012")) // -< 32 değer
    }
    
}

class PasswordOtherCriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bcsdsadasds"))
    }
}

class PasswordUppercaseCriteriaTests: XCTestCase {
    func testUppercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("ABCDEFEADASDGRTHTH"))
    }
    func testUppercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("sasdasdasdasd"))
    }
}

class PasswordLowercaseCriteriaTests: XCTestCase {
    func testLowercaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("asdasdasdasd"))
    }
    func testLowercaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("ASFASFASDASD"))
    }
}

class PasswordDigitCriteriaTests: XCTestCase {
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("12315126682368236326"))
    }
    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("!%^'+&+/+%(+%(+%+%&^+%"))
    }
}

class PasswordSpecialCriteriaTests: XCTestCase {
    func testSpecialMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("@:?!()$#,./...\\\\\\\\"))
    }
    func testSpecialNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("123125192359235oasdasdasdADKAOPSDKASDAKSD"))
    }
}

class PasswordLengthAndNoSpaceMet: XCTestCase {
    func testLengthAndNoSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("123456781203192312051"))
    }
    func testLengthAndNoSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("102931209312osfjspdfjsdpfjd spfosdfposdfkpsodkfsodkfpsdkfpsdkfposdkfposkd"))
    }
}
