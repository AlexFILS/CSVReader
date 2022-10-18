//
//  DummyReader.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 14.10.2022.
//

import Foundation

class DummyReader: CSVReaderType {
    
    var rawData: [[String]]?
    
    class DummyReaderOutputObject: CSVDisplayable {
        init(
            store: String,
            city: String,
            country: String,
            availability: String
        ) {
            super.init(
                mainLabelTitle: "Store Type",
                mainLabelSubtitle: store,
                secondaryLabelTitle: city + ", " + country,
                secondaryLabelSubtitle:  availability
            )
        }
    }
    
    typealias ReaderOutput = DummyReaderOutputObject
    var numberOfColumns: Int
    var loadedCSVData: String?
    
    // MARK: - Init
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
    }
    
    // MARK: - Functions
    
    func readAndParseData() async -> [ReaderOutput] {
        let result = await parseData()
        return result
    }
    
    private func parseData() async -> [DummyReaderOutputObject] {
        return [
            DummyReaderOutputObject(
                store: "Fashion Outlet",
                city: "Bucharest",
                country: "Romania",
                availability: "Mon-Sun 7:00-20:00"
            ),
            DummyReaderOutputObject(
                store: "Pet Shop",
                city: "Iasi",
                country: "Romania",
                availability: "Mon-Fri"
            ),
            DummyReaderOutputObject(
                store: "House&Garden",
                city: "Constanta",
                country: "Romania",
                availability: "Mon-Fri 800h-2000h"
            )
        ]
    }
}
