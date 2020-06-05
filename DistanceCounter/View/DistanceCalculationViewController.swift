//
//  DistanceCalculationViewController.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 04/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import UIKit

class DistanceCalculationViewController: UIViewController {
    
    @IBOutlet weak var startPointTitleLabel: CustomLabel!
    @IBOutlet weak var startPointLatitudeTextField: CustomTextField!
    @IBOutlet weak var startPointLongitudeTextField: CustomTextField!
    @IBOutlet weak var finishPointTitleLabel: CustomLabel!
    @IBOutlet weak var finishPointLatitudeTextField: CustomTextField!
    @IBOutlet weak var finishPointLongtitudeTextField: CustomTextField!
    @IBOutlet weak var calculateDistanceButton: CustomButton!
    @IBOutlet weak var distanceInKilometersTitleLabel: CustomLabel!
    @IBOutlet weak var distanceInMetersTitleLabel: CustomLabel!
    @IBOutlet weak var startPointInfoTextView: CustomTextView!
    @IBOutlet weak var finishPointInfoTextView: CustomTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
