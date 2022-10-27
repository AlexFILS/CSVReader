//
//  CSVDataViewModelType.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 17.10.2022.
//

import Foundation

protocol CSVDataViewModelType {
    var coordinator: MainCoordinator? { get }
    func numberOfRows(inSection: Int) -> Int
    func modelForIndex(_ indexPath: IndexPath) -> CellType?
}
