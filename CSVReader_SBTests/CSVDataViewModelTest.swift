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
        let name: String
        let surname: String
        let dateOfBirth: Date
     
        init(name: String, surname: String, dateOfBirth: Date) {
            self.name = name
            self.surname = surname
            self.dateOfBirth = dateOfBirth
            super.init(mainLabelTitle: "Full Name",
                       mainLabelSubtitle: self.name + " " + self.surname,
                       secondaryLabelTitle: "Date of Birth",
                       secondaryLabelSubtitle:   self.dateOfBirth.ISO8601Format())
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
        
        XCTAssertEqual(viewModel.numberOfRows, 3)
        
        var csvEntry = viewModel.viewModelForIndex(1)
        var dobAsString =  Date(timeIntervalSinceReferenceDate: 123456789.0).ISO8601Format()
        XCTAssertEqual(csvEntry?.mainLabelTitle, "Full Name")
        XCTAssertEqual(csvEntry?.mainLabelSubtitle, "Tucker Chris")
        XCTAssertEqual(csvEntry?.secondaryLabelTitle, "Date of Birth")
        XCTAssertEqual(csvEntry?.secondaryLabelSubtitle, dobAsString)
        
        csvEntry = viewModel.viewModelForIndex(2)
        dobAsString =  Date(timeIntervalSinceReferenceDate: 123456489.0).ISO8601Format()
        XCTAssertEqual(csvEntry?.mainLabelTitle, "Full Name")
        XCTAssertEqual(csvEntry?.mainLabelSubtitle, "Griffin Peter")
        XCTAssertEqual(csvEntry?.secondaryLabelTitle, "Date of Birth")
        XCTAssertEqual(csvEntry?.secondaryLabelSubtitle, dobAsString)
        
        csvEntry = viewModel.viewModelForIndex(3)
        XCTAssertNil(csvEntry)
    }
}
