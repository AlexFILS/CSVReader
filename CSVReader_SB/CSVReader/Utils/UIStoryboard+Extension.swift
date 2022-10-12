//
//  UIStoryboard+Extension.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 12.10.2022.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case home = "Home"
        case csvViewer = "CSVDataFlow"
        
        var flowName: String {
            return rawValue
        }
    }
}
