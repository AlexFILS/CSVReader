//
//  HomeViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var openCsvButton: UIButton!
    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openCsvButtonTapped(_ sender: Any) {
        self.viewModel.coordinator?.goToCSVViewer()
    }
    
}

