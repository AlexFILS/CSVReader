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
}
class HomeViewModel: HomeViewModelType {
    private(set )var csvReader: any CSVReaderType
    weak var coordinator : MainCoordinator?
    
    // MARK: - Init
    init(csvReader: any CSVReaderType, coordinator: MainCoordinator?) {
        self.csvReader = csvReader
        self.coordinator = coordinator
    }
        
    func loadCSVUrl(data: String?) {
        self.csvReader.loadedCSVData = data
    }
    
    var readyToParseData: Bool {
        self.csvReader.loadedCSVData != nil
    }
}
