//
//  CSVDataViewModelTest.swift
//  CSVReader_SBTests
//
//  Created by Alexandru Mihai on 12.10.2022.
//


import XCTest

@testable import CSVReader_SB
class CSVDataViewModelTest: XCTestCase {
    
    // Use a random class that may have data loaded from a CSV and cand be displayed in the csv reader table
    class Person: CSVDisplayable {
        init(name: String, surname: String, dateOfBirth: Date) {
            super.init(mainLabelTitle: "Full Name",
                       mainLabelSubtitle: name + " " + surname,
                       secondaryLabelTitle: "Date of Birth",
                       secondaryLabelSubtitle: dateOfBirth.ISO8601Format())
        }
    }
    
    private func randomPersons() -> [CSVDisplayable] {
        return [
            Person(
                name: "Alex",
                surname: "Mihai",
                dateOfBirth: Date(timeIntervalSinceReferenceDate: 123456789.0)
            ),
            Person(
                name: "Tucker",
                surname: "Chris",
                dateOfBirth: Date(timeIntervalSinceReferenceDate: 123456789.0)
            ),
            Person(
                name: "Griffin",
                surname: "Peter",
                dateOfBirth: Date(timeIntervalSinceReferenceDate: 123456489.0)
            )
        ]
    }
    
    func testViewModel() {
        let viewModel = CSVDataViewModel(data: self.randomPersons())
        
        XCTAssertEqual(viewModel.numberOfRows(inSection: 0), 3)
        
        let model = viewModel.modelForIndex(IndexPath(row: 1, section: 0))
        switch model {
        case .issueCell(let viewModel):
            let dobAsString =  Date(timeIntervalSinceReferenceDate: 123456789.0).ISO8601Format()
            XCTAssertEqual(viewModel.mainLabelTitle, "Full Name")
            XCTAssertEqual(viewModel.mainLabelSubtitle, "Tucker Chris")
            XCTAssertEqual(viewModel.secondaryLabelTitle, "Date of Birth")
            XCTAssertEqual(viewModel.secondaryLabelSubtitle, dobAsString)
        case .none:
            XCTFail("Couldn't return a cell.")
        }
       
        
        let secondModel = viewModel.modelForIndex(IndexPath(row: 2, section: 0))
        switch secondModel {
        case .issueCell(let viewModel):
            let dobAsString =  Date(timeIntervalSinceReferenceDate: 123456489.0).ISO8601Format()
            XCTAssertEqual(viewModel.mainLabelTitle, "Full Name")
            XCTAssertEqual(viewModel.mainLabelSubtitle, "Griffin Peter")
            XCTAssertEqual(viewModel.secondaryLabelTitle, "Date of Birth")
            XCTAssertEqual(viewModel.secondaryLabelSubtitle, dobAsString)
        case .none:
            XCTFail("Couldn't return a cell.")
        }

       let noCSVEntry = viewModel.modelForIndex(IndexPath(row: 3, section: 0))
        switch noCSVEntry {
        case .issueCell(_):
            XCTFail("Returned model where should have been none.")
        case .none:
            XCTAssertNil(noCSVEntry)
        }
    }
}
