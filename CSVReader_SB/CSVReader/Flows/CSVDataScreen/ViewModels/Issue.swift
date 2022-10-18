//
//  Issue.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import Foundation

//Should have been in the 'Models' folder but Xcode doesn't allow me to move files for some reason...
class Issue: CSVDisplayable, Equatable {
    init(
        name: String,
        surname: String,
        dateOfBirth: String,
        issueCount: String
    ) {
        
        super.init(
            mainLabelTitle: name + " " + surname,
            mainLabelSubtitle: dateOfBirth,
            secondaryLabelTitle: "Issues",
            secondaryLabelSubtitle:  issueCount
        )
    }
    
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.secondaryLabelSubtitle == rhs.secondaryLabelSubtitle &&
        lhs.mainLabelSubtitle == rhs.mainLabelSubtitle &&
        lhs.mainLabelTitle == rhs.mainLabelTitle &&
        lhs.secondaryLabelTitle == rhs.secondaryLabelTitle
    }
}
