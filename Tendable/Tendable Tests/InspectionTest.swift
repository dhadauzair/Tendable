//
//  InspectionTest.swift
//  Tendable Tests
//
//  Created by Uzair Dhada on 7/17/24.
//

import XCTest
@testable import Tendable

final class InspectionTest: XCTestCase {
    var inspectionViewController = InspectionViewController()
    
    override func setUp() {
        super.setUp()
        inspectionViewController.loadViewIfNeeded()
    }
    
    func test_is_valid_if_isAllQACompleted_fail() {
        var questions = [Question]()
        let question1 = Question(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: nil)
        let question2 = Question(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: 1)
        questions.append(question1)
        questions.append(question2)
        let category = Category(id: nil, name: nil, questions: questions)
        let survey = Survey(id: nil, categories: [category])
        let inspection = Inspection(id: nil, inspectionType: nil, area: nil, survey: survey, isSubmitted: false)
        inspectionViewController.inspection = inspection
        
        XCTAssertEqual(false, inspectionViewController.isAllQACompleted())
//        XCTAssertFalse(inspectionViewController.isAllQACompleted()) Another way to test
    }
    
    func test_is_valid_if_AllQACompleted_success() {
        var questions = [Question]()
        let question1 = Question(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: 1)
        let question2 = Question(id: nil, name: nil, answerChoices: nil, selectedAnswerChoiceId: 1)
        questions.append(question1)
        questions.append(question2)
        let category = Category(id: nil, name: nil, questions: questions)
        let survey = Survey(id: nil, categories: [category])
        let inspection = Inspection(id: nil, inspectionType: nil, area: nil, survey: survey, isSubmitted: false)
        inspectionViewController.inspection = inspection
        
        XCTAssertEqual(true, inspectionViewController.isAllQACompleted())
//        XCTAssertTrue(inspectionViewController.isAllQACompleted()) Another wy to test
    }
}
