//
//  PastInspectionListViewModel.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/15/24.
//

import Foundation

class PastInspectionListViewModel {
    func getPastInspections(completion: @escaping (Result<[InspectionModel], Error>) -> Void) {
        APIBaseService.shared.request(.startInspection, completion: completion)
    }
}
