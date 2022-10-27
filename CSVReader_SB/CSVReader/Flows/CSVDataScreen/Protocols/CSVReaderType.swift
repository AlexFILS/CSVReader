//
//  CSVReaderType.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 17.10.2022.
//

import Foundation

protocol CSVReaderType {
    associatedtype ReaderOutput
    var numberOfColumns: Int { get }
    var loadedCSVData: String? { get set }
    var rawData: [[String]]? { get }
    func readAndParseData() async -> [ReaderOutput]
}
