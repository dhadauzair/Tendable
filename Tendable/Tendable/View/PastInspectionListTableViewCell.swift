//
//  PastInspectionListTableViewCell.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/15/24.
//

import UIKit

class PastInspectionListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var inspection = Inspection()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(inspection: Inspection) {
        self.inspection = inspection
        titleLabel.text = "Area: \(inspection.area?.name ?? "")" + " Inspection ID: \(inspection.id ?? 0)"
    }
}
