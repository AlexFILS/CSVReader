//
//  IssueReaderTest.swift
//  CSVReader_SBTests
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import XCTest

@testable import CSVReader_SB
class IssueReaderTest: XCTestCase {
    
    func testCanHandleType() async {
        
        // Wrong CSV format
        let reader = IssueReader(numberOfColumns: 4)
        var data = "colum1, colum2 ,colum3"
        reader.loadedCSVData = data
        await reader.readRawData()
        var parsedIssues = await reader.parseData()
        XCTAssertTrue(parsedIssues.count == 0)
        
        // Wrong CSV format: Only column description present but no entries
        data = "colum1, colum2"
        reader.loadedCSVData = data
        await reader.readRawData()
        parsedIssues = await reader.parseData()
        XCTAssertTrue(parsedIssues.count == 0)
        
        // Good CSV format: correct number of columns and entries
        data = "colum title 1, colum title 2, column title 3, column title 4 \n entry 1, entry 2, column entry 3, column entry 4"
        reader.loadedCSVData = data
        await reader.readRawData()
        parsedIssues = await reader.parseData()
        XCTAssertTrue(parsedIssues.count == 1)
        
        // Worng csv format: only one row in file (names of entries)
        data = "colum title 1, colum title 2, column title 3, column title 4"
        reader.loadedCSVData = data
        await reader.readRawData()
        parsedIssues = await reader.parseData()
        XCTAssertTrue(parsedIssues.count == 0)
    }
    
    func testEmptyOutput() async {
        let reader = IssueReader(numberOfColumns: 4)
        await reader.readRawData()
        let parsedIssues = await reader.parseData()
        XCTAssertEqual(parsedIssues, [])
    }
    
    func testOnltOneEntryAvailable() async {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        await reader.readRawData()
        let parsedIssues = await reader.parseData()
        XCTAssertEqual(parsedIssues.count, 1)
    }
    
    func testDataHasNoEntriesExceptRowNames() async {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r"
        reader.loadedCSVData = data
        await reader.readRawData()
        let parsedIssues = await reader.parseData()
        XCTAssertEqual(parsedIssues.count, 0)
    }
    
    func testReaderOutputValues() async {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        await reader.readRawData()
        let parsedIssues = await reader.parseData()
        if let issue = parsedIssues.first {
            let expectedIssue = Issue(
                name: "Theo",
                surname: "Jansen",
                dateOfBirth: "1978-01-02T00:00:00",
                issueCount: "5"
            )
            XCTAssertEqual(issue, expectedIssue)
        } else {
            XCTFail("Did not return an issue object.")
        }
    }
    
    func testCorruptValues() async {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name,1\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,1,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        await reader.readRawData()
        let parsedIssues = await reader.parseData()
        XCTAssertEqual(parsedIssues.count, 0)
    }
    
    func testReaderOutputValuesWithCorrectAndCorruptData() async {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\nAlex\",\"Mihai\",5,\"1993-01-18T03:00:00\\,\"extra column\",\\r\n"
        reader.loadedCSVData = data
        await reader.readRawData()
        let parsedIssues = await reader.parseData()
        if let issue = parsedIssues.first {
            let expectedIssue = Issue(
                name: "Theo",
                surname: "Jansen",
                dateOfBirth: "1978-01-02T00:00:00",
                issueCount: "5"
            )
            XCTAssertEqual(issue, expectedIssue)
        } else {
            XCTFail("Did not return an issue object.")
        }
        
        XCTAssertEqual(parsedIssues.count, 1)
    }
}
