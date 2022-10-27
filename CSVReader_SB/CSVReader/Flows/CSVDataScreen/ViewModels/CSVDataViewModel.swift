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

class CSVDataViewModel: CSVDataViewModelType {
  
    typealias CellTypeEnum = CellType
    
    public struct Section {
        let items: [CellType]
    }
    
    weak var coordinator: MainCoordinator?
    private var sections = [Section]()
    
    // MARK: - Init
    
    init(data: [CSVDisplayable]) {
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
    
    // MARK: - Functions
    
    func numberOfRows(inSection: Int) -> Int {
        return self.sections.elementAtPosition(inSection)?.items.count ?? 0
    }
    
    private func generateSections(data: [CSVDisplayable]) {
        var sections = [Section]()
        if let issueSection = self.generateIssuesSection(data: data) {
            sections.append(issueSection)
        }
        self.sections = sections
    }
    
    private func generateIssuesSection(data: [CSVDisplayable]) -> Section? {
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
