//
//  InspectionViewController.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import UIKit

class InspectionViewController: UIViewController {

    @IBOutlet weak var inspectionTableView: UITableView!
    
    var viewModel = InspectionViewModel()
    var inspection: Inspection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        startNewInspection()
    }
    
    func startNewInspection() {
        viewModel.startNewInspection { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let inspectionModel):
                    self?.inspection = inspectionModel.inspection
                    self?.inspectionTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func isAllQACompleted() -> Bool {
        var isAllQuestionAnswered = true
        inspection?.survey?.categories?.forEach({ category in
            guard let questions = category.questions else { return }
            questions.forEach { question in
                if question.selectedAnswerChoiceId == nil {
                    isAllQuestionAnswered = false
                    return
                }
            }
        })
        
        return isAllQuestionAnswered
    }
    
    func calculateInspectionScore() -> Double {
        guard let categories = inspection?.survey?.categories else {
            return 0.0
        }

        let questions = extractQuestions(from: categories)
        let scores = calculateScores(for: questions)
        return sumScores(scores)
    }

    func extractQuestions(from categories: [Category]) -> [Question] {
        return categories.flatMap { $0.questions ?? [] }
    }

    func calculateScores(for questions: [Question]) -> [Double] {
        return questions.compactMap { question in
            question.answerChoices?.first(where: { $0.id == question.selectedAnswerChoiceId })?.score
        }
    }

    func sumScores(_ scores: [Double]) -> Double {
        return scores.reduce(0.0, +)
    }

    
    @IBAction func didSelctSubmitButton(_ sender: Any) {
        if (isAllQACompleted()) {
            let answeredInspectionModel = InspectionModel(inspection: inspection)
            viewModel.submitInspection(selectedAnswerInspection: answeredInspectionModel) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        CoreDataService.sharedInstance.saveInspectionsEntity(userMailId: Utility.sharedInstance.getLoggedInUser(), inspection: self?.inspection ?? Inspection())
                        self?.showAlert(title: Constants.CommonLocalisations.appNameTitle, message: Constants.CommonLocalisations.totalScore + "\(self?.calculateInspectionScore() ?? 0.0)", actionTitle: nil, completion: {
                            self?.navigationController?.popViewController(animated: true)
                        })
                    case .failure(_): break
                    }
                }
            }
        }
    }
    
    @IBAction func didSelectSaveDraftButton(_ sender: Any) {
    }
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension InspectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return inspection?.survey?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inspectionCategory = inspection?.survey?.categories?[section]
        return inspectionCategory?.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InspectionQATableViewCell.identifier, for: indexPath) as? InspectionQATableViewCell else {
            return UITableViewCell()
        }
        let inspectionCategory = inspection?.survey?.categories?[indexPath.section]
        let question = inspectionCategory?.questions?[indexPath.row]

        cell.configureCell(question: question?.name ?? "", answers: question?.answerChoices, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return inspection?.survey?.categories?[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - InspectionQATableViewCellDelegate
extension InspectionViewController: InspectionQATableViewCellDelegate {
    func didSelectAnswer(_ answerId: Int, forQuestionAt indexPath: IndexPath) {
        let newAnswerChoice = inspection?.survey?.categories?[indexPath.section].questions?[indexPath.row].answerChoices?.map({ answerChoice in
            var modifiedAnswerChoice = answerChoice
            if answerChoice.id == answerId {
                modifiedAnswerChoice.isAnswerSelected = true
            } else {
                modifiedAnswerChoice.isAnswerSelected = false
            }
            return modifiedAnswerChoice
        })
        inspection?.survey?.categories?[indexPath.section].questions?[indexPath.row].answerChoices = newAnswerChoice
        inspection?.survey?.categories?[indexPath.section].questions?[indexPath.row].selectedAnswerChoiceId = answerId
        inspectionTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
