//
//  HomeScreenTest.swift
//  CSVReader_SBUITests
//
//  Created by Alexandru Mihai on 16.10.2022.
//

import XCTest

class HomeScreenTest: XCTestCase {
    
    func testHomeScreenInitialLayout() {
        let app = XCUIApplication()
        app.launch()
        let label = app.staticTexts[HomeScreenIdentifiers.csvStatusLabelId.rawValue]
        XCTAssertTrue(label.exists)
        XCTAssertEqual(label.label, HomeScreenLiterals.csvLabelNoCSVLoaded.rawValue)
        
        let findCSVButton = app.buttons[HomeScreenIdentifiers.loadCSVButtonId.rawValue]
        XCTAssertTrue(findCSVButton.exists)
        XCTAssertTrue(findCSVButton.isEnabled)
        
        let parseCSVButtonParse = app.buttons[HomeScreenIdentifiers.openCSVButtonId.rawValue]
        XCTAssertTrue(parseCSVButtonParse.exists)
        XCTAssertFalse(parseCSVButtonParse.isEnabled)
    }
    
    func testHomeScreenCSVSelected() {
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["Find and load CSV"]/*[[".buttons[\"Find and load CSV\"].staticTexts[\"Find and load CSV\"]",".buttons[\"loadCSVButtonId\"].staticTexts[\"Find and load CSV\"]",".staticTexts[\"Find and load CSV\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.collectionViews["File View"].cells["issues, csv"]/*[[".otherElements[\"Browse View\"]",".otherElements[\"DOC.browsingRoot Source: com.apple.FileProvider.LocalStorage, Title: On My iPhone\"].collectionViews[\"File View\"]",".cells[\"issues, csv, 1\/25\/16, 181 bytes\"]",".cells[\"issues, csv\"]",".collectionViews[\"File View\"]"],[[[-1,4,2],[-1,1,2],[-1,0,1]],[[-1,4,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).tap()
        let loadCSVButtonParse = app.buttons[HomeScreenIdentifiers.openCSVButtonId.rawValue]
        XCTAssertTrue(loadCSVButtonParse.exists)
        XCTAssertTrue(loadCSVButtonParse.isEnabled)
        
        let label = app.staticTexts[HomeScreenIdentifiers.csvStatusLabelId.rawValue]
        XCTAssertTrue(label.exists)
        
        let expectedString = String(format: HomeScreenLiterals.csvSelected.rawValue, "issues.csv")
        XCTAssertEqual(label.label, expectedString)
    }
}
