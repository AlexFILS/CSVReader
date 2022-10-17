//
//  CSVReaderScreenTest.swift
//  CSVReader_SBUITests
//
//  Created by Alexandru Mihai on 17.10.2022.
//

import Foundation
import XCTest

class CSVReaderSCreenTest: XCTestCase {
    
    func testComponents() {
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.buttons["loadCSVButtonId"]/*[[".buttons[\"Find and load CSV\"]",".buttons[\"loadCSVButtonId\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.collectionViews["File View"].cells["issues, csv"]/*[[".otherElements[\"Browse View\"]",".otherElements[\"DOC.browsingRoot Source: com.apple.FileProvider.LocalStorage, Title: On My iPhone\"].collectionViews[\"File View\"]",".cells[\"issues, csv, 1\/25\/16, 181 bytes\"]",".cells[\"issues, csv\"]",".collectionViews[\"File View\"]"],[[[-1,4,2],[-1,1,2],[-1,0,1]],[[-1,4,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Parse CSV data"]/*[[".buttons[\"Parse CSV data\"].staticTexts[\"Parse CSV data\"]",".buttons[\"openCSVButtonId\"].staticTexts[\"Parse CSV data\"]",".staticTexts[\"Parse CSV data\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let tableView = app.tables.containing(.cell, identifier: CSVDataScreenIdentifiers.csvDataCellId.rawValue)
        XCTAssertTrue(tableView.element.exists)
        XCTAssertEqual(tableView.cells.count, 3)
        
        let mainLabelTitle = tableView.staticTexts[CSVDataScreenIdentifiers.mainLabelTitleId.rawValue]
        let mainLabelDescription = tableView.staticTexts[CSVDataScreenIdentifiers.mainLabelDescriptionId.rawValue]
        let secondaryLabelTitle = tableView.staticTexts[CSVDataScreenIdentifiers.secondaryLabelTitleId.rawValue]
        let secondaryLabelDescription = tableView.staticTexts[CSVDataScreenIdentifiers.secondaryLabelDescriptionId.rawValue]
        
        XCTAssertTrue(mainLabelTitle.exists)
        XCTAssertTrue(mainLabelDescription.exists)
        XCTAssertTrue(secondaryLabelTitle.exists)
        XCTAssertTrue(secondaryLabelDescription.exists)
    }
}
