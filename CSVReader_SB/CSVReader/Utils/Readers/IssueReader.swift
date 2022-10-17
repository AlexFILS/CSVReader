//
//  IssueReader.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import Foundation

class IssueReader: CSVReaderType {
    typealias ReaderOutput = Issue
    var rawData: [[String]]?
    var loadedCSVData: String?
    private(set) var numberOfColumns: Int
    
    // MARK: - Init
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
    }
    
    // MARK: - Functions
    
    func readAndParseData() async -> [ReaderOutput] {
        await self.readRawData()
        let result = await parseData()
        return result
    }
    
    func readRawData() async {
        guard let data = self.loadedCSVData else {
            return
        }
        var result: [[String]] = []
        let rows = data.components(separatedBy: .newlines)
        for row in rows {
            let fields = row.replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
            if fields.count == self.numberOfColumns {
                result.append(fields)
            }
        }
        
        switch result.count {
        case 2...:
            result.remove(at: 0)
            self.rawData = result
        default:
            self.rawData = nil
        }
    }
    
    func parseData() async -> [Issue] {
        guard let data = self.rawData else {
            return []
        }
        var issues: [Issue] = []
        data.forEach { element in
            if element.count == self.numberOfColumns {
                let issue = Issue(name: element[0],
                                       surname: element[1],
                                       dateOfBirth: element[3],
                                       issueCount: element[2])
                issues.append(issue)
            }
        }
        return issues
    }
}
