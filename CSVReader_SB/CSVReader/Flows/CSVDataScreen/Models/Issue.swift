//
//  Issue.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import Foundation

class Issue: CSVDisplayable {
    
    init(name: String,
         surname: String,
         dateOfBirth: String,
         issueCount: String) {
        
        super.init(mainLabelTitle: name + " " + surname,
                   mainLabelSubtitle: dateOfBirth,
                   secondaryLabelTitle: "Issues",
                   secondaryLabelSubtitle:  issueCount)
    }
}
