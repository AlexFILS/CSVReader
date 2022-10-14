//
//  BaseViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 12.10.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingIndicator() {
        self.view.showBlurLoader()
    }
    
    func hideLoadingIndicator() {
        self.view.removeBlurLoader()
    }
}
