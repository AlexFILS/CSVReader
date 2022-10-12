//
//  CSVDataCell.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import UIKit

class CSVDataCell: UITableViewCell {
    @IBOutlet weak var mainLabelTitle: UILabel!
    @IBOutlet weak var mainLabelDescription: UILabel!
    @IBOutlet weak var secondaryLabelTitle: UILabel!
    @IBOutlet weak var secondaryLabelDescription: UILabel!
    
    func configureCell(from viewModel: CSVDisplayableType) {
        mainLabelTitle.text = viewModel.mainLabelTitle
        mainLabelDescription.text = viewModel.mainLabelSubtitle
        secondaryLabelTitle.text = viewModel.secondaryLabelTitle
        secondaryLabelDescription.text = viewModel.secondaryLabelSubtitle
    }
}
