//
//  PastInspectionListViewModel.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/15/24.
//

import Foundation

class PastInspectionListViewModel {
//    func getUpComingInspections(completion: @escaping (Result<[InspectionModel], Error>) -> Void) {
//        APIBaseService.shared.request(.randomInspections, completion: completion)
//    }
    
    func getPastInspectionsLocally() -> [Inspection] {
        let pastInspectionsEntity = CoreDataService.sharedInstance.getInspectionsEntity(Utility.sharedInstance.getLoggedInUser())
        guard let pastInspectionsEntity = pastInspectionsEntity else { return [] }
        let pastSavedInspection = CoreDataService.sharedInstance.getAllSavedInspections(inspectionEntity: pastInspectionsEntity)
        return pastSavedInspection
    }
}
