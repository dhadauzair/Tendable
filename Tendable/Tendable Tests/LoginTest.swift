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
    
    func test_is_valid_when_login_fail() {
        XCTAssertEqual(true, loginViewController.userLoginOrRegistrationFailed(errorCode: 400, WithEndpoint: .loginUser))
        XCTAssertEqual(true, loginViewController.userLoginOrRegistrationFailed(errorCode: 401, WithEndpoint: .loginUser))
    }
    
    func test_is_valid_when_login_success() {
        XCTAssertEqual(false, loginViewController.userLoginOrRegistrationFailed(errorCode: 200, WithEndpoint: .loginUser))
    }
    
    func test_is_valid_when_registration_fail() {
        XCTAssertEqual(true, loginViewController.userLoginOrRegistrationFailed(errorCode: 400, WithEndpoint: .loginUser))
        XCTAssertEqual(true, loginViewController.userLoginOrRegistrationFailed(errorCode: 401, WithEndpoint: .loginUser))
    }
    
    func test_is_valid_when_registraion_success() {
        XCTAssertEqual(false, loginViewController.userLoginOrRegistrationFailed(errorCode: 200, WithEndpoint: .loginUser))
    }
}
