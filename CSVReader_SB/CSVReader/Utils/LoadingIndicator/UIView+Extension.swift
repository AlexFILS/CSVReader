//
//  UIView+Extension.swift
//  CSVReader_SB
//
//  Created by Alexandru Mihai on 14.10.2022.
//

import UIKit

extension UIView {
    func showBlurLoader() {
        let blurView = BlurView(frame: frame)
        self.addSubview(blurView)
    }

    func removeBlurLoader() {
        if let blurView = subviews.first(where: { $0 is BlurView }) {
            blurView.removeFromSuperview()
        }
    }
}
