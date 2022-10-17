//
//  MainCoordinator.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorType, CSVCapableCoordinatorType {
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    // MARK: - Functions
    
    func start() {
        self.goToHomePage()
    }
    
    func goToHomePage() {
        let homeViewController = HomeViewController.instantiate(flow: .home)
        let csvReader = IssueReader(numberOfColumns: 4)
        let homeViewModel = HomeViewModel.init(csvReader: csvReader, coordinator: self)
        homeViewModel.coordinator = self
        homeViewController.viewModel = homeViewModel
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func goToCSVViewer(data: [CSVDisplayable]) {
        let csvDataViewController = CSVDataViewController.instantiate(flow: .csvViewer)
        let viewModel = CSVDataViewModel.init(data: data)
        viewModel.coordinator = self
        csvDataViewController.viewModel = viewModel
        navigationController.pushViewController(csvDataViewController, animated: true)
    }
    
    func popController() {
        navigationController.popViewController(animated: true)
    }
    
    func openFilePicker(onController controller: HomeViewController) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.commaSeparatedText], asCopy: true)
        documentPicker.delegate = controller
        documentPicker.modalPresentationStyle = .formSheet
        controller.present(documentPicker, animated: true)
    }
}
