//
//  Inspection.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation

struct InspectionModel: Codable {
    var inspection: Inspection?
}

struct Inspection: Codable {
    let id: Int
    let inspectionType: InspectionType
    let area: Area
    let survey: Survey
}

struct InspectionType: Codable {
    let id: Int
    let name: String
    let access: String
}

struct Area: Codable {
    let id: Int
    let name: String
}

struct Survey: Codable {
    let id: Int
    let categories: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
    let questions: [Question]
}

struct Question: Codable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoice]
    var selectedAnswerChoiceId: Int?
}

struct AnswerChoice: Codable {
    let id: Int
    let name: String
    let score: Float
}


