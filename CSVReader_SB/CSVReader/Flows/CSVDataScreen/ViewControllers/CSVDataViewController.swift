//
//  CSVDataViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

class CSVDataViewController: BaseViewController {
    var viewModel: CSVDataViewModel!
    @IBOutlet weak var csvDataTableView: UITableView!
    
    override func viewDidLoad() {
        self.csvDataTableView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewModel?.coordinator?.popController()
    }
    
    @IBAction func backtapped(_ sender: Any) {
        self.viewModel?.coordinator?.popController()
    }
}

extension CSVDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CSVDataCell") as? CSVDataCell,
              let item = self.viewModel.modelForIndex(indexPath) else {
            return UITableViewCell()
        }
        switch item {
        case .issueCell(let viewModel):
            cell.configureCell(from: viewModel)
        }
        return cell
    }
}
