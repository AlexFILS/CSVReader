//
//  Constants.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 14.10.2022.
//

import Foundation

// MARK: - Button titles

enum ButtonTitles: String {
    case findCsvButtonTitle = "Find and load CSV"
    case parseCsvDataButtonTitle = "Parse CSV data"
}

// MARK: - Alerts

enum UnsupportedCSVTypeAlert: String {
    case alertErrorTitle = "Something went wrong!"
    case alertErrorMessage = "CSV empty, corrupt or not supported."
    case alertButtonOK = "OK"
}

// MARK: - Cells

enum CellIdentifiers: String {
    case issueCell = "CSVDataCell"
}

// MARK: - HomeViewModel

enum HomeScreenLiterals: String {
    case csvLabelNoCSVLoaded = "No CSV loaded."
    case csvSelected = "Selected CSV: %@"
    case csvSelectedDefaultLabel = "A CSV was selected."
}


// MARK: - Identifiers

enum HomeScreenIdentifiers: String {
    case loadedCSVLabel
    case loadCSVButton
    case openCSVButton
}
