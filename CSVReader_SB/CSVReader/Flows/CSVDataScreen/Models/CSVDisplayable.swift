//
//  CSVDisplayable.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

class CSVDisplayable: CSVDataCellType {
    var mainLabelTitle: String
    var mainLabelSubtitle: String
    var secondaryLabelTitle: String
    var secondaryLabelSubtitle: String
    
    init(mainLabelTitle: String, mainLabelSubtitle: String, secondaryLabelTitle: String, secondaryLabelSubtitle: String) {
        self.mainLabelTitle = mainLabelTitle
        self.mainLabelSubtitle = mainLabelSubtitle
        self.secondaryLabelTitle = secondaryLabelTitle
        self.secondaryLabelSubtitle = secondaryLabelSubtitle
    }
}
