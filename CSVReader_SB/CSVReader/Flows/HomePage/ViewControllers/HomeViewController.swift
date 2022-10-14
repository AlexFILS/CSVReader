//
//  HomeViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import UIKit
import UniformTypeIdentifiers

class HomeViewController: BaseViewController {

    @IBOutlet weak var openCsvButton: UIButton!
    @IBOutlet weak var loadCsvButton: UIButton!
    var viewModel: HomeViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialScreenSetup()
    }
    
    @IBAction func loadCsvButtonTapped(_ sender: Any) {
        self.viewModel.coordinator?.openFilePicker(onController: self)
    }
    
    @IBAction func openCsvButtonTapped(_ sender: Any) {
        guard let data = self.viewModel.csvReader.readCsv() as? [Issue] else {
            return
        }
        self.viewModel.coordinator?.goToCSVViewer(data: data)
    }
    
    private func setupLabels() {
        self.openCsvButton.setTitle(self.viewModel.parseCsvDataButtonTitle, for: .normal)
        self.loadCsvButton.setTitle(self.viewModel.findCsvButtonTitle, for: .normal)
    }
    
    private func initialScreenSetup() {
        self.setupLabels()
        self.openCsvButton.isEnabled = self.viewModel.readyToParseData
    }
}

extension HomeViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first,
              let data = try? String(contentsOfFile: url.path)  else {
            self.viewModel.loadCSVUrl(data: nil)
            self.openCsvButton.isEnabled = self.viewModel.readyToParseData
            return
        }
        self.viewModel.loadCSVUrl(data: data)
        self.openCsvButton.isEnabled = self.viewModel.readyToParseData
    }
}
