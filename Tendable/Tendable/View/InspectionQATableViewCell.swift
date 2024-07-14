//
//  InspectionQATableViewCell.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import UIKit

// MARK: InspectionQATableViewCell Protocol
protocol InspectionQATableViewCellDelegate {
    func didSelectAnswer(_ answerId: Int, forQuestionAt indexPath: IndexPath)
}

class InspectionQATableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    
    var questionIndexPath: IndexPath?
    var delegate: InspectionQATableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(question: String, answers: [AnswerChoice]?, indexPath: IndexPath) {
        questionLabel.text = question
        questionIndexPath = indexPath
        answerStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        guard let answers = answers else { return }
        for answer in answers {
            let button = UIButton(type: .system)
            button.setTitle(answer.name, for: .normal)
            button.tag = answer.id ?? answers.count+1
            if answer.isAnswerSelected {
                button.backgroundColor = UIColor.lightGray
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.systemBlue, for: .normal)
            }
            button.addTarget(self, action: #selector(didSelectAnswerButton(_:)), for: .touchUpInside)
            answerStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func didSelectAnswerButton(_ sender: UIButton) {
        guard let questionIndexPath = questionIndexPath else { return }
        delegate?.didSelectAnswer(sender.tag, forQuestionAt: questionIndexPath)
    }

}
