//
//  CustomButton.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 04/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        setupAppearance()
    }
    
    private func setupAppearance() {
        layer.cornerRadius = 10
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Fonts.titleRegular
    }
}
