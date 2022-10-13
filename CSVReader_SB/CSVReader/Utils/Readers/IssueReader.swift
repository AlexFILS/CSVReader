//
//  IssueReader.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 13.10.2022.
//

import Foundation

protocol CSVReaderType<ReaderOutput> {
    associatedtype ReaderOutput
    var numberOfColumns: Int { get }
    var loadedCSVData: String? { get set }
    func readCsv() -> [ReaderOutput]?
    func csvTypeIsSupported() -> Bool
}

class IssueReader: CSVReaderType {
    typealias ReaderOutput = Issue
    var loadedCSVData: String?
    var numberOfColumns: Int
    
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
    }
    
    func readCsv() -> [Issue]? {
        guard let data = self.loadedCSVData else {
            return nil
        }
        var result: [[String]] = []
        var issues: [Issue] = []
        let rows = data.components(separatedBy: .newlines)
        for row in rows {
            let fields = row.replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
            if fields.count == self.numberOfColumns {
                result.append(fields)
            }
        }
        result.remove(at: 0)
        result.forEach { element in
            let issue = Issue(name: element[0],
                              surname: element[1],
                              dateOfBirth: element[3],
                              issueCount: element[2])
            issues.append(issue)
        }
        return issues
    }
    
    func csvTypeIsSupported() -> Bool {
        return (loadedCSVData?.components(separatedBy: ",").count ?? 0) == self.numberOfColumns
    }
}
