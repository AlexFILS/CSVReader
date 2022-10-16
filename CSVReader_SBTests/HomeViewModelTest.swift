//
//  HomeViewModelTest.swift
//  CSVReader_SBTests
//
//  Created by Alexandru Mihai on 14.10.2022.
//

import XCTest

class HomeViewModelTest: XCTestCase {
    
    let issueData = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
    
    let corruptIssueData = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\n" // no rows, just section names
    
    func testCanLoadIssueData() {
        let coordinator = MainCoordinator(navController: UINavigationController())
        let issueReader = IssueReader(numberOfColumns: 4)
        let homeViewModel = HomeViewModel(csvReader: issueReader, coordinator: coordinator)
        
        XCTAssertFalse(homeViewModel.readyToParseData)
        XCTAssertNil(homeViewModel.csvReader.loadedCSVData)
        
        homeViewModel.loadCSVUrl(data: issueData)
        XCTAssertTrue(homeViewModel.readyToParseData)
        XCTAssertNotNil(homeViewModel.csvReader.loadedCSVData)
        
        homeViewModel.loadCSVUrl(data: nil)
        XCTAssertFalse(homeViewModel.readyToParseData)
        XCTAssertNil(homeViewModel.csvReader.loadedCSVData)
    }
    
    func testCannotLoadIssueData() {
        let coordinator = MainCoordinator(navController: UINavigationController())
        let issueReader = IssueReader(numberOfColumns: 4)
        let homeViewModel = HomeViewModel(csvReader: issueReader, coordinator: coordinator)
        
        homeViewModel.loadCSVUrl(data: corruptIssueData)
        XCTAssertTrue(homeViewModel.readyToParseData)
        XCTAssertNotNil(homeViewModel.csvReader.loadedCSVData)
    }
    
    func testCanLoadDifferentReaderType() {
        let coordinator = MainCoordinator(navController: UINavigationController())
        let dummyReader = DummyReader(numberOfColumns: 4)
        let homeViewModel = HomeViewModel(csvReader: dummyReader, coordinator: coordinator)
        
        XCTAssertFalse(homeViewModel.readyToParseData)
        XCTAssertNil(homeViewModel.csvReader.loadedCSVData)
        
        homeViewModel.loadCSVUrl(data: issueData)
        XCTAssertTrue(homeViewModel.readyToParseData)
        XCTAssertNotNil(homeViewModel.csvReader.loadedCSVData)
        
        homeViewModel.loadCSVUrl(data: nil)
        XCTAssertFalse(homeViewModel.readyToParseData)
        XCTAssertNil(homeViewModel.csvReader.loadedCSVData)
    }
    
    func testSelectedCSVLabel() {
        let coordinator = MainCoordinator(navController: UINavigationController())
        let dummyReader = DummyReader(numberOfColumns: 4)
        let homeViewModel = HomeViewModel(csvReader: dummyReader, coordinator: coordinator)
        
        let expectedCSVName = "Issues.csv"
        let validPath = "alexandrumihai/Downloads/Issues.csv"
        let expectedResult = String(format: HomeScreenLiterals.csvSelected.rawValue, expectedCSVName)
        
        if let url = URL(string: validPath) {
            XCTAssertEqual(homeViewModel.getCSVName(fromPath: url), expectedResult)
        } else {
            XCTFail("Could not read url")
        }
    }
}
