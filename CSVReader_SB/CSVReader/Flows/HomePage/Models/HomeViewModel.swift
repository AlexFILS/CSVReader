//
//  HomeViewModel.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation

class HomeViewModel {
    
    weak var coordinator : MainCoordinator?
    
    func goToCSVViewer() {
        coordinator?.goToCSVViewer()
    }
}
