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
    @IBOutlet weak var loadedCsvLabel: UILabel!
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
        Task { [weak self] in
            await self?.returnCompiledData()
        }
    }
    
    // MARK: - Functions
    
    private func returnCompiledData() async {
        self.showLoadingIndicator()
        if let data = await self.viewModel.csvReader.readAndParseData() as? [CSVDisplayable],
           data.count > 0 {
            self.hideLoadingIndicator()
            self.viewModel.coordinator?.goToCSVViewer(data: data)
        } else {
            self.hideLoadingIndicator()
            self.showAlert()
        }
    }
    
    private func setupLabels() {
        self.openCsvButton.setTitle(ButtonTitles.parseCsvDataButtonTitle.rawValue, for: .normal)
        self.loadCsvButton.setTitle(ButtonTitles.findCsvButtonTitle.rawValue, for: .normal)
        self.loadedCsvLabel.text = HomeScreenLiterals.csvLabelNoCSVLoaded.rawValue
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
        self.loadedCsvLabel.text = self.viewModel.getCSVName(fromPath: url)
        self.viewModel.loadCSVUrl(data: data)
        self.openCsvButton.isEnabled = self.viewModel.readyToParseData
    }
}
