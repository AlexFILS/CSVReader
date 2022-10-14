//
//  CSVDataViewModel.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

protocol CSVDataViewModelType {
    var coordinator: MainCoordinator? { get }
}

class CSVDataViewModel: CSVDataViewModelType {
    typealias ContainedDataType = CSVDisplayable
    
    public enum CellType {
        case issueCell(cellViewModel: ContainedDataType)
    }
    
    public struct Section {
        let items: [CellType]
    }
    
    weak var coordinator: MainCoordinator?
    private var sections = [Section]()
    
    // MARK: - Init
    init(data: [ContainedDataType]) {
        self.generateSections(data: data)
    }
    
    func modelForIndex(_ indexPath: IndexPath) -> CellType? {
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
    
    func generateSections(data: [ContainedDataType]) {
        var sections = [Section]()
        if let issueSection = self.generateIssuesSection(data: data) {
            sections.append(issueSection)
        }
        self.sections = sections
    }
    
    func generateIssuesSection(data: [ContainedDataType]) -> Section? {
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
