//
//  IssueTest.swift
//  CSVReader_SBTests
//
//  Created by Alexandru Mihai on 18.10.2022.
//

import XCTest

class IssueTest: XCTestCase {

    func testIssueInit() {
        let expectedName = "Stewie"
        let expectedSurname = "Griffin"
        let expectedIssues = "3"
        let expectedDob = "08-11-1999"
        
        let issue = Issue(
            name: expectedName,
            surname: expectedSurname,
            dateOfBirth: expectedDob,
            issueCount: expectedIssues
        )
        XCTAssertEqual(issue.mainLabelTitle, expectedName + " " + expectedSurname)
        XCTAssertEqual(issue.mainLabelSubtitle, expectedDob)
        XCTAssertEqual(issue.secondaryLabelTitle, CSVDataCellConstants.issuesLabelText.rawValue)
        XCTAssertEqual(issue.secondaryLabelSubtitle, expectedIssues)
    }

    func testIssueEquality() {
        let expectedName = "Stewie"
        let expectedSurname = "Griffin"
        let expectedIssues = "3"
        let expectedDob = "08-11-1999"
        
        let firstIssue = Issue(
            name: expectedName,
            surname: expectedSurname,
            dateOfBirth: expectedDob,
            issueCount: expectedIssues
        )
        
        let secondIssue = Issue(
            name: expectedName,
            surname: expectedSurname,
            dateOfBirth: expectedDob,
            issueCount: expectedIssues
        )
        
        XCTAssertEqual(firstIssue, secondIssue)
    }
}
