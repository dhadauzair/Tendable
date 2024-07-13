//
//  InspectionQATableViewCell.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/14/24.
//

import UIKit

class InspectionQATableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(question: String, answers: [AnswerChoice]?) {
        questionLabel.text = question
        guard let answers = answers else { return }
        for answer in answers {
            let button = UIButton(type: .system)
            button.setTitle(answer.name, for: .normal)
            button.tag = answer.id ?? answers.count+1
            answerStackView.addArrangedSubview(button)
        }
    }

}
