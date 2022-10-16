//
//  CSVCorruptDataCell.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 16.10.2022.
//

import UIKit

class CSvCorruptDatacell: UITableViewCell {
    @IBOutlet weak var corruptCSVLabel: UILabel!
    
    func configureCell() {
        self.corruptCSVLabel.text = CorruptCell.corruptDataLabel.rawValue
    }
}
