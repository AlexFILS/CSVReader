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
    var findCsvButtonTitle: String { get }
    var parseCsvDataButtonTitle: String { get }
    func goToCSVViewer()
    func loadCSVUrl(data: String?)
}
class HomeViewModel: HomeViewModelType {
    var csvReader: any CSVReaderType
    weak var coordinator : MainCoordinator?
    let findCsvButtonTitle = "Find and load CSV"
    let parseCsvDataButtonTitle = "Parse CSV data"
    
    init(csvReader: any CSVReaderType<Issue>, coordinator: MainCoordinator?) {
        self.csvReader = csvReader
        self.coordinator = coordinator
    }
    
    func goToCSVViewer() {
        if let uiElements = self.csvReader.readCsv() as? [CSVDisplayable] {
            coordinator?.goToCSVViewer(data: uiElements )
        }
    }
    
    func loadCSVUrl(data: String?) {
        self.csvReader.loadedCSVData = data
    }
    
    var readyToParseData: Bool {
        self.csvReader.loadedCSVData != nil
    }
}
