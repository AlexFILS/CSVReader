//
//  Storyboarded.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 12.10.2022.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(flow: UIStoryboard.Storyboard) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(flow: UIStoryboard.Storyboard) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: flow.flowName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
