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
    var id: Int?
    var inspectionType: InspectionType?
    var area: Area?
    var survey: Survey?
    var isSubmitted = false
    
    enum CodingKeys: String, CodingKey {
        case id, inspectionType, area, survey
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(inspectionType, forKey: .inspectionType)
        try container.encodeIfPresent(area, forKey: .area)
        try container.encodeIfPresent(survey, forKey: .survey)
    }
}

struct InspectionType: Codable {
    var id: Int?
    var name: String?
    var access: String?
}

struct Area: Codable {
    var id: Int?
    var name: String?
}

struct Survey: Codable {
    var id: Int?
    var categories: [Category]?
}

struct Category: Codable {
    var id: Int?
    var name: String?
    var questions: [Question]?
}

struct Question: Codable {
    var id: Int?
    var name: String?
    var answerChoices: [AnswerChoice]?
    var selectedAnswerChoiceId: Int?
}

struct AnswerChoice: Codable {
    var id: Int?
    var name: String?
    var score: Double?
    var isAnswerSelected = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, score
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(score, forKey: .score)
    }
}


