//
//  HomeViewController.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 11.10.2022.
//

import UIKit
import UniformTypeIdentifiers

class HomeViewController: BaseViewController {
    enum CustomError: Error {
        case notAnItOrADouble(String)
    }
    
    @IBOutlet weak var openCsvButton: UIButton!
    @IBOutlet weak var loadCsvButton: UIButton!
    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialScreenSetup()
    }
    
    @IBAction func loadCsvButtonTapped(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.commaSeparatedText], asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
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
            self.viewModel.loadCVCUrl(data: nil)
            self.openCsvButton.isEnabled = self.viewModel.readyToParseData
            return
        }
        self.viewModel.loadCVCUrl(data: data)
        self.openCsvButton.isEnabled = self.viewModel.readyToParseData
    }
}
