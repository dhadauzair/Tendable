//
//  InspectionViewModel.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation

class InspectionViewModel {
    func startNewInspection(completion: @escaping (Result<InspectionModel, Error>) -> Void) {
        APIBaseService.shared.request(.startInspection, completion: completion)
    }
    
    func submitInspection(selectedAnswerInspection: InspectionModel, completion: @escaping (Result<BoolResponse, Error>) -> Void) {
        let selectedAnswerInspectionDictinary = selectedAnswerInspection.dictionary ?? [:]
        APIBaseService.shared.request(.submitInspection, body: selectedAnswerInspectionDictinary, completion: completion)
    }
    
}
