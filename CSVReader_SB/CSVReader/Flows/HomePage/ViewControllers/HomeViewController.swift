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
        self.initialScreenSetup()
        super.viewDidLoad()
    }
    
    // MARK: - Button actions
    @IBAction func loadCsvButtonTapped(_ sender: Any) {
        self.viewModel.coordinator?.openFilePicker(onController: self)
    }
    
    @IBAction func openCsvButtonTapped(_ sender: Any) {
        self.showLoadingIndicator()
        guard self.viewModel.csvReader.csvTypeIsSupported(),
              let data = self.viewModel.csvReader.parseData() as? [Issue] else {
            self.hideLoadingIndicator()
            self.showAlert()
            return
        }
        self.hideLoadingIndicator()
        self.viewModel.coordinator?.goToCSVViewer(data: data)
    }
    
    // MARK: - Functions
    private func setupLabels() {
        self.openCsvButton.setTitle(ButtonTitles.parseCsvDataButtonTitle.rawValue, for: .normal)
        self.loadCsvButton.setTitle(ButtonTitles.findCsvButtonTitle.rawValue, for: .normal)
    }
    
    private func initialScreenSetup() {
        self.setupLabels()
        self.openCsvButton.isEnabled = self.viewModel.readyToParseData
    }
    
    private func showAlert() {
        AlertBuilder(viewController: self)
            .withTitle(UnsupportedCSVTypeAlert.alertErrorTitle.rawValue)
            .andMessage(UnsupportedCSVTypeAlert.alertErrorMessage.rawValue)
            .preferredStyle(.alert)
            .onSuccessAction(title: UnsupportedCSVTypeAlert.alertButtonOK.rawValue, { _ in })
            .show()
    }
}

// MARK: - Document Picker Delegate
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
