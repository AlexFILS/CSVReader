//
//  CSVIssueReaderTest.swift
//  CSVReader_SBTests
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import XCTest

class CSVIssueReaderTest: XCTestCase {
    
    
    func testCanHandleType() {
        let reader = IssueReader(numberOfColumns: 2)
        var data = "colum1, colum2 ,colum3"
        reader.loadedCSVData = data
        XCTAssertFalse(reader.csvTypeIsSupported())
        
        data = "colum1, colum2"
        reader.loadedCSVData = data
        XCTAssertTrue(reader.csvTypeIsSupported())
    }
    
    func testReaderOutputArray() {
        let reader = IssueReader(numberOfColumns: 4)
        XCTAssertEqual(reader.readCsv(), nil)
        
        var data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        XCTAssertEqual(reader.readCsv()?.count ?? 0, 1)
        
        data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r"
        reader.loadedCSVData = data
        XCTAssertEqual(reader.readCsv()?.count ?? 0, 0)
    }
    
    func testReaderOutputValues() {
        let reader = IssueReader(numberOfColumns: 4)
        let data = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\r\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\r\n"
        reader.loadedCSVData = data
        
        if let issue = reader.readCsv()?.first {
            let expectedIssue = Issue(name: "Theo",
                                      surname: "Jansen",
                                      dateOfBirth: "1978-01-02T00:00:00",
                                      issueCount: "5")
            XCTAssertEqual(issue, expectedIssue)
        } else {
            XCTFail("Did not return an issue object.")
        }
    }
}
