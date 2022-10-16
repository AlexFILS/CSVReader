//
//  HomeViewModel.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

protocol HomeViewModelType {
    var csvReader: any CSVReaderType { get }
    var coordinator: MainCoordinator? {get }
    var readyToParseData: Bool { get }
    func loadCSVUrl(data: String?)
    func getCSVName(fromPath csvPath: URL) -> String
}
class HomeViewModel: HomeViewModelType {
    private(set) var csvReader: any CSVReaderType
    weak var coordinator : MainCoordinator?
    
    var readyToParseData: Bool {
        self.csvReader.loadedCSVData != nil
    }
    
    // MARK: - Init
    init(csvReader: any CSVReaderType, coordinator: MainCoordinator?) {
        self.csvReader = csvReader
        self.coordinator = coordinator
    }
        
    func loadCSVUrl(data: String?) {
        self.csvReader.loadedCSVData = data
    }
    
    func getCSVName(fromPath csvPath: URL) -> String {
        if let csvName = csvPath.path.components(separatedBy: "/").last {
            return String(format: HomeScreenLiterals.csvSelected.rawValue, csvName)
        } else {
            return HomeScreenLiterals.csvSelectedDefaultLabel.rawValue
        }
    }
}
