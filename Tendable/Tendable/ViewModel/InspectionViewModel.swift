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
}
