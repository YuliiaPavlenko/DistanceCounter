//
//  CustomLabel.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 04/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    override func awakeFromNib() {
        setupAppearance()
    }
    
    private func setupAppearance() {
        textColor = .darkText
        font = Fonts.titleBold
    }
}
