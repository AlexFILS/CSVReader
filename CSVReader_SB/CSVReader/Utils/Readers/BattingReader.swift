//
//  BattingReader.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 14.10.2022.
//

import Foundation

/*
 Used to test a large CSV file (over 6MB) included in the test files in the git repo
 Usage: Inject this reader in the HomeViewModel, init with the number of columns, and change the cast type to [Batting]
 */

class Batting: CSVDisplayable {
    
    init(
        player:String,
        year: String,
        stint: String,
        team: String,
        igid: String,
        gValue: String,
        abValue: String,
        rValue: String,
        hValue: String,
        b2Value: String,
        b3Value: String,
        hrValue: String,
        rbiValue: String,
        sbValue: String,
        csValue: String,
        bbValue: String,
        soValue: String,
        ibbValue: String,
        hbbValue: String,
        shValue: String,
        sfValue: String,
        gidp: String
    ) {
        
        super.init(mainLabelTitle: player + "/" + year + "/" + stint + "/" + team,
                   mainLabelSubtitle: igid + "/" + gValue + "/" + abValue + "/" + rValue,
                   secondaryLabelTitle: b2Value + "/" + hValue + "/" + rbiValue + "/" + bbValue,
                   secondaryLabelSubtitle:  shValue + "/" + sfValue + "/" + gidp + "/" + csValue)
    }
}


class BattingReader: CSVReaderType {
    
    typealias ReaderOutput = Batting
    var numberOfColumns: Int
    var loadedCSVData: String?
    var rawData: [[String]]?
    
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
    }
    
    func readAndParseData() async -> [ReaderOutput] {
        await self.readRawData()
        let result = await parseData()
        return result
    }
    
    func readRawData() async {
        guard let data = self.loadedCSVData else {
            return
        }
        var result: [[String]] = []
        let rows = data.components(separatedBy: .newlines)
        for row in rows {
            let fields = row.replacingOccurrences(of: "\"", with: "").components(separatedBy: ",")
            if fields.count == self.numberOfColumns {
                result.append(fields)
            }
        }
        
        switch result.count {
        case 2...:
            result.remove(at: 0)
            self.rawData = result
        default:
            self.rawData = nil
        }
    }
    
    func parseData() async -> [Batting] {
        guard let data = rawData else {
            return []
        }
        var battings: [Batting] = []
        data.forEach { csvEntry in
            if element.count == self.numberOfColumns {
                let batting = Batting(
                    player: csvEntry[0], year: csvEntry[1], stint: csvEntry[2], team: csvEntry[3], igid: csvEntry[4], gValue: csvEntry[5], abValue: csvEntry[6], rValue: csvEntry[7], hValue: csvEntry[8], b2Value: csvEntry[9], b3Value: csvEntry[10], hrValue: csvEntry[11], rbiValue: csvEntry[12], sbValue: csvEntry[13], csValue: csvEntry[14], bbValue: csvEntry[15], soValue: csvEntry[16], ibbValue: csvEntry[17], hbbValue: csvEntry[18], shValue: csvEntry[19], sfValue: csvEntry[20], gidp: csvEntry[21]
                )
                battings.append(batting)
            }
        }
        return battings
    }
}
