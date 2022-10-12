//
//  CSVDataViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import Foundation
import UIKit

class CSVDataViewController: BaseViewController {
    var viewModel: (any CSVDataViewModelType)?
    @IBOutlet weak var csvDataTableView: UITableView!
    
    override func viewDidLoad() {
        self.csvDataTableView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewModel?.coordinator?.finishFlow()
    }
}

extension CSVDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowCount = self.viewModel?.numberOfRows {
            return rowCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CSVDataCell") as? CSVDataCell,
              let dataViewModel = self.viewModel?.viewModelForIndex(indexPath.row) else {
            return UITableViewCell()
        }
        cell.configureCell(from: dataViewModel)
        return cell
    }
}
