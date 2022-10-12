//
//  Array+Extension.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

extension Array {
    
    func elementAtPosition(_ position: Int) -> Element? {
        if self.count > position {
            return self[position]
        } else {
            return nil
        }
    }
}
