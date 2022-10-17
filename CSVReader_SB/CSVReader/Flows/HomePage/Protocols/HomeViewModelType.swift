//
//  HomeViewModelType.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 17.10.2022.
//

import Foundation

protocol HomeViewModelType {
    var csvReader: any CSVReaderType { get }
    var coordinator: MainCoordinator? {get }
    var readyToParseData: Bool { get }
    func loadCSVUrl(data: String?)
    func getCSVName(fromPath csvPath: URL) -> String
}
