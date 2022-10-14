//
//  IssueReaderTest.swift
//  CSVReader_SBTests
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import XCTest

class IssueReaderTest: XCTestCase {
    
    
    func testCanHandleType() {
        // Wrong CSV format: too many columns
        let reader = IssueReader(numberOfColumns: 2)
        var data = "colum1, colum2 ,colum3"
        reader.loadedCSVData = data
        reader.readRawData()
        XCTAssertFalse(reader.csvTypeIsSupported())
        
        // Wrong CSV format: Only column description present but no entries
        data = "colum1, colum2"
        reader.loadedCSVData = data
        reader.readRawData()
        XCTAssertFalse(reader.csvTypeIsSupported())
        
        // Good CSV format: correct number of columns and entries
        data = "colum title 1, colum title 2 \n entry 1, entry 2"
        reader.loadedCSVData = data
        reader.readRawData()
        XCTAssertTrue(reader.csvTypeIsSupported())
    }
    
    func testReaderOutputArray() {
        let reader = IssueReader(numberOfColumns: 4)
        XCTAssertEqual(reader.parseData(), [])
        
        var data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        reader.readRawData()
        var parsedIssues = reader.parseData()
        XCTAssertEqual(parsedIssues.count, 1)
        
        data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r"
        reader.loadedCSVData = data
        reader.readRawData()
        parsedIssues = reader.parseData()
        XCTAssertEqual(parsedIssues.count, 0)
    }
    
    func testReaderOutputValues() {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        reader.readRawData()
        if let issue = reader.parseData().first {
            let expectedIssue = Issue(name: "Theo",
                                      surname: "Jansen",
                                      dateOfBirth: "1978-01-02T00:00:00",
                                      issueCount: "5")
            XCTAssertEqual(issue, expectedIssue)
        } else {
            XCTFail("Did not return an issue object.")
        }
    }
    
    func testCorruptValues() {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name,1\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,1,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        XCTAssertFalse(reader.csvTypeIsSupported())
    }
}
