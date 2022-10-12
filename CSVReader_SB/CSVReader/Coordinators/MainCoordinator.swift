//
//  MainCoordinator.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        self.goToHomePage()
    }

    func goToHomePage() {
        let homeViewController = HomeViewController.instantiate(flow: .home)
        let homeViewModel = HomeViewModel.init()
        homeViewModel.coordinator = self
        homeViewController.viewModel = homeViewModel
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func goToCSVViewer() {
        let child = CSVDataFlowCoordinator(navController: navigationController)
        child.parentCoordinator = self
        children.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }
}
