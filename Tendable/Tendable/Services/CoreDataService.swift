//
//  CoreDataService.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import Foundation
import CoreData
import UIKit

final class CoreDataService: NSObject {
    
    static let sharedInstance = CoreDataService()
    
    private override init() { }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveUserEntity(userMailId: String) {
        let newUser = TendableUserEntity(context: context)
        newUser.email = userMailId
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func getUserEntity(_ userMailId: String) -> TendableUserEntity? {
        let fetchRequest = NSFetchRequest<TendableUserEntity>(entityName: TendableUserEntity.identifier)
        // Create and set the predicate
        let predicate = NSPredicate(format: "email == %@", userMailId)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed fetching: \(error)")
        }
        return nil
    }
    
    func getInspections(_ userMailId: String) -> [TendableInspectionsEntity]? {
        let fetchRequest = NSFetchRequest<TendableInspectionsEntity>(entityName: "TendableInspectionsEntity")
        // Create and set the predicate
        let predicate = NSPredicate(format: "email == %@", userMailId)
        fetchRequest.predicate = predicate

        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Failed fetching: \(error)")
        }
        return nil
    }
    
    func saveInspectionsEntity(userMailId: String, inspection: Inspection) {
        let inspectionEntity = createInspectionEntity(inspection: inspection)
        let inspectionAreaEntity = createInspectionAreaEntity(inspection: inspection)
        let inspectionTypeEntity = createInspectionTypeEntity(inspection: inspection)
        let inspectionSurveyEntity = createInspectionSurveyEntity(inspection: inspection)
        
        inspectionEntity.area = inspectionAreaEntity
        inspectionEntity.type = inspectionTypeEntity
        inspectionEntity.survey = inspectionSurveyEntity
        
        inspectionAreaEntity.inspection = inspectionEntity
        inspectionTypeEntity.inspection = inspectionEntity
        inspectionSurveyEntity.inspection = inspectionEntity
        
        if let user = getUserEntity(userMailId) {
            user.addToInspection(inspectionEntity)
            inspectionEntity.email = user.email
        }
        
        do {
            try context.save()
        } catch {
            // Handle the error appropriately
            print("Failed to save context: \(error)")
        }
    }

    func createInspectionEntity(inspection: Inspection) -> TendableInspectionsEntity {
        let inspectionEntity = TendableInspectionsEntity(context: context)
        inspectionEntity.id = Int64(inspection.id ?? 0)
        return inspectionEntity
    }

    func createInspectionAreaEntity(inspection: Inspection) -> TendableAreaEntity {
        let inspectionAreaEntity = TendableAreaEntity(context: context)
        inspectionAreaEntity.id = Int64(inspection.area?.id ?? 0)
        inspectionAreaEntity.name = inspection.area?.name
        return inspectionAreaEntity
    }

    func createInspectionTypeEntity(inspection: Inspection) -> TendableInspectionTypeEntity {
        let inspectionTypeEntity = TendableInspectionTypeEntity(context: context)
        inspectionTypeEntity.id = Int64(inspection.inspectionType?.id ?? 0)
        inspectionTypeEntity.name = inspection.inspectionType?.name
        inspectionTypeEntity.access = inspection.inspectionType?.access
        return inspectionTypeEntity
    }

    func createInspectionSurveyEntity(inspection: Inspection) -> TendableSurveyEntity {
        let inspectionSurveyEntity = TendableSurveyEntity(context: context)
        inspectionSurveyEntity.id = Int64(inspection.survey?.id ?? 0)
        
        if let categories = inspection.survey?.categories {
            for category in categories {
                let categoriesEntity = createCategoriesEntity(category: category)
                inspectionSurveyEntity.addToCategories(categoriesEntity)
            }
        }
        return inspectionSurveyEntity
    }

    func createCategoriesEntity(category: Category) -> TendableCategoriesEntity {
        let categoriesEntity = TendableCategoriesEntity(context: context)
        categoriesEntity.id = Int64(category.id ?? 0)
        categoriesEntity.name = category.name
        
        if let questions = category.questions {
            for question in questions {
                let questionEntity = createQuestionEntity(question: question)
                categoriesEntity.addToQuestions(questionEntity)
            }
        }
        return categoriesEntity
    }

    func createQuestionEntity(question: Question) -> TendableQuestionsEntity {
        let questionEntity = TendableQuestionsEntity(context: context)
        questionEntity.id = Int64(question.id ?? 0)
        questionEntity.name = question.name
        questionEntity.selectedAnswerChoiceId = Int64(question.selectedAnswerChoiceId ?? 0)
        
        if let choices = question.answerChoices {
            for choice in choices {
                let answerChoicesEntity = createAnswerChoicesEntity(choice: choice)
                questionEntity.addToAnswerChoices(answerChoicesEntity)
            }
        }
        return questionEntity
    }

    func createAnswerChoicesEntity(choice: AnswerChoice) -> TendableAnswerChoicesEntity {
        let answerChoicesEntity = TendableAnswerChoicesEntity(context: context)
        answerChoicesEntity.id = Int64(choice.id ?? 0)
        answerChoicesEntity.name = choice.name
        answerChoicesEntity.score = choice.score ?? 0.0
        return answerChoicesEntity
    }
    
    func getInspectionFromInspectionEntity(inspectionEntity: TendableInspectionsEntity) -> Inspection {
        var cInspection = Inspection()
        cInspection.id = Int(inspectionEntity.id)
        cInspection.inspectionType = getInspectionType(from: inspectionEntity.type)
        cInspection.area = getArea(from: inspectionEntity.area)
        cInspection.survey = getSurvey(from: inspectionEntity.survey)
        return cInspection
    }

    func getInspectionType(from entity: TendableInspectionTypeEntity?) -> InspectionType {
        var cInspectionType = InspectionType()
        cInspectionType.id = Int(entity?.id ?? 0)
        cInspectionType.name = entity?.name
        cInspectionType.access = entity?.access
        return cInspectionType
    }

    func getArea(from entity: TendableAreaEntity?) -> Area {
        var cArea = Area()
        cArea.id = Int(entity?.id ?? 0)
        cArea.name = entity?.name
        return cArea
    }

    func getSurvey(from entity: TendableSurveyEntity?) -> Survey {
        var cSurvey = Survey()
        cSurvey.id = Int(entity?.id ?? 0)
        if let categories = entity?.categories?.allObjects as? [TendableCategoriesEntity] {
            cSurvey.categories = categories.map { getCategory(from: $0) }
        }
        return cSurvey
    }

    func getCategory(from entity: TendableCategoriesEntity) -> Category {
        var cCategory = Category()
        cCategory.id = Int(entity.id)
        cCategory.name = entity.name
        if let questions = entity.questions?.allObjects as? [TendableQuestionsEntity] {
            cCategory.questions = questions.map { getQuestion(from: $0) }
        }
        return cCategory
    }

    func getQuestion(from entity: TendableQuestionsEntity) -> Question {
        var cQuestion = Question()
        cQuestion.id = Int(entity.id)
        cQuestion.name = entity.name
        cQuestion.selectedAnswerChoiceId = Int(entity.selectedAnswerChoiceId)
        if let choices = entity.answerChoices?.allObjects as? [TendableAnswerChoicesEntity] {
            cQuestion.answerChoices = choices.map { getAnswerChoice(from: $0, selectedAnswerChoiceId: entity.selectedAnswerChoiceId) }
        }
        return cQuestion
    }

    func getAnswerChoice(from entity: TendableAnswerChoicesEntity, selectedAnswerChoiceId: Int64) -> AnswerChoice {
        var cAnswerChoice = AnswerChoice()
        cAnswerChoice.id = Int(entity.id)
        cAnswerChoice.name = entity.name
        cAnswerChoice.score = entity.score
        cAnswerChoice.isAnswerSelected = selectedAnswerChoiceId == entity.id
        return cAnswerChoice
    }
}
