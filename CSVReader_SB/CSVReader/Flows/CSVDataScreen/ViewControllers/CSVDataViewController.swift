//
//  CSVDataViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

class CSVDataViewController: BaseViewController {
    var viewModel: (any CSVDataViewModelType)!
    @IBOutlet weak var csvDataTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.csvDataTableView.dataSource = self
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewModel?.coordinator?.popController()
    }
}

// MARK: - TableViewDataSource

extension CSVDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.issueCell.rawValue) as? CSVDataCell,
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
