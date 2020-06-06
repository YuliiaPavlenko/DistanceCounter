//
//  CustomTextField.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 04/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        setupAppearance()
    }
    
    private func setupAppearance() {
        font = Fonts.textFieldFont
        textColor = .lightGray
        
        keyboardType = .numbersAndPunctuation
    }
}
