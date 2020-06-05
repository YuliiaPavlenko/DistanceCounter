//
//  CustomTextView.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 04/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    
    override func awakeFromNib() {
        setupAppearance()
    }
    
    private func setupAppearance() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.systemGray.cgColor
        textColor = .darkText
    }
}
