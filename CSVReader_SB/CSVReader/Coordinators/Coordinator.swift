//
//  Coordinator.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

// This is our base coordinator layout
protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    func start()
    func childDidFinish(_ child: Coordinator?)
}

protocol DeferringCoordinator {
    func finishFlow()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        print("Function not implemented.")
    }
}
