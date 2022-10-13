//
//  CSVDataViewModel.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

protocol CSVDataViewModelType {
    associatedtype ContainedDataType: CSVDisplayableType
    var coordinator: MainCoordinator? { get }
    var data: [ContainedDataType] { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    func viewModelForIndex(_ index: Int) -> ContainedDataType?
}

class CSVDataViewModel: CSVDataViewModelType {
    typealias ContainedDataType = CSVDisplayable
    weak var coordinator: MainCoordinator?
    var data: [CSVDisplayable]
    var numberOfSections = 0
    
    init(data: [CSVDisplayable]) {
        self.data = data
    }
    
    func viewModelForIndex(_ index: Int) -> CSVDisplayable? {
        return data.elementAtPosition(index)
    }
    
    var numberOfRows: Int {
        return data.count
    }
}
