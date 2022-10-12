//
//  CSVDataFlowCoordinator.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

protocol CSVDataFlowCoordinatorType: Coordinator, DeferringCoordinator {
    func goBack()
}

class CSVDataFlowCoordinator: CSVDataFlowCoordinatorType {

    weak var parentCoordinator: MainCoordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let csvDataViewController = CSVDataViewController.instantiate(flow: .csvViewer)
        let data = [CSVDisplayable(mainLabelTitle: "main 1",
                                 mainLabelSubtitle: "sub 1",
                                 secondaryLabelTitle: "sec 1",
                                 secondaryLabelSubtitle: "sec sub 1")]
        let viewModel = CSVDataViewModel.init(data: data)
        viewModel.coordinator = self
        csvDataViewController.viewModel = viewModel
        navigationController.pushViewController(csvDataViewController, animated: true)
    }
    
    func goBack() {
        
    }
    
    func finishFlow() {
        self.parentCoordinator?.childDidFinish(self)
    }
}
