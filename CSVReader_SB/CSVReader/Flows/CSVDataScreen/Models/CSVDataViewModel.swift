//
//  CSVDataViewModel.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

enum CellType {
    case issueCell(cellViewModel: CSVDisplayableType)
}

protocol CSVDataViewModelType {
    associatedtype ContainedDataType
    var coordinator: MainCoordinator? { get }
    func numberOfRows(inSection: Int) -> Int 
    func modelForIndex(_ indexPath: IndexPath) -> CellType?
    
}

class CSVDataViewModel: CSVDataViewModelType {
    typealias CellTypeEnum = CellType
    typealias ContainedDataType = CSVDisplayable
    
    public struct Section {
        let items: [CellType]
    }
    
    weak var coordinator: MainCoordinator?
    private var sections = [Section]()
    
    // MARK: - Init
    
    init(data: [ContainedDataType]) {
        self.generateSections(data: data)
    }
    
    func modelForIndex(_ indexPath: IndexPath) -> CellTypeEnum? {
        if let section = self.sections.elementAtPosition(indexPath.section),
           let model = section.items.elementAtPosition(indexPath.row) {
            return model
        } else {
            return nil
        }
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return self.sections.elementAtPosition(inSection)?.items.count ?? 0
    }
    
    private func generateSections(data: [ContainedDataType]) {
        var sections = [Section]()
        if let issueSection = self.generateIssuesSection(data: data) {
            sections.append(issueSection)
        }
        self.sections = sections
    }
    
    private func generateIssuesSection(data: [ContainedDataType]) -> Section? {
        var cells = [CellType]()
        data.forEach { element in
            cells.append(.issueCell(cellViewModel: element))
        }
        return Section(items: cells)
    }
    
    var numberOfSections: Int {
        return self.sections.count
    }
}
