//
//  LoginTest.swift
//  Tendable Tests
//
//  Created by Uzair Dhada on 7/17/24.
//

@testable import Tendable
import XCTest

final class LoginTest: XCTestCase {
    
    var loginViewController = LoginViewController()
    
    override func setUp() {
        super.setUp()
        loginViewController.loadViewIfNeeded()
    }
    
    func test_is_valid_email() {
        XCTAssertEqual(true, loginViewController.isEmailValid(emailId: "test@test.com"))
    }
    
    func test_is_valid_password() {
        XCTAssertEqual(true, loginViewController.isPasswordValid(password: "123"))
    }
}
