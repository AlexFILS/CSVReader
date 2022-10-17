//
//  CSVDisplayable.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

class CSVDisplayable: CSVDisplayableType {
    let mainLabelTitle: String
    let mainLabelSubtitle: String
    let secondaryLabelTitle: String
    let secondaryLabelSubtitle: String
    
    // MARK: - Init
    
    init(mainLabelTitle: String, mainLabelSubtitle: String, secondaryLabelTitle: String, secondaryLabelSubtitle: String) {
        self.mainLabelTitle = mainLabelTitle
        self.mainLabelSubtitle = mainLabelSubtitle
        self.secondaryLabelTitle = secondaryLabelTitle
        self.secondaryLabelSubtitle = secondaryLabelSubtitle
    }
}
