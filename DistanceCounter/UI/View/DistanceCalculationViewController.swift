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
    @IBOutlet weak var finishPointLongitudeTextField: CustomTextField!
    @IBOutlet weak var calculateDistanceButton: CustomButton!
    @IBOutlet weak var distanceInKilometersTitleLabel: CustomLabel!
    @IBOutlet weak var distanceInMetersTitleLabel: CustomLabel!
    @IBOutlet weak var startPointInfoTextView: CustomTextView!
    @IBOutlet weak var finishPointInfoTextView: CustomTextView!
    
    var activeTextField: UITextField?
    
    var viewModel = DistanceCalculationViewModel()
    
    let spinerVC = SpinnerViewController()

    @IBAction func calculateDistanceButtonClicked(_ sender: Any) {
        activeTextField?.resignFirstResponder()
        viewModel.calculateDistanceButtonClicked(startLatitude: startPointLatitudeTextField.text!,
                                                 startLongitude: startPointLongitudeTextField.text!,
                                                 finishLatitude: finishPointLatitudeTextField.text!,
                                                 finishLongitude: finishPointLongitudeTextField.text!)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self

        setupTextFieldDelegates()
        setupButon()
        addKeyboardObservers()
        
        [startPointLatitudeTextField, startPointLongitudeTextField,
         finishPointLatitudeTextField, finishPointLongitudeTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        switch textField {
        case startPointLatitudeTextField:
            viewModel.validateStartLatitudeField(with: startPointLatitudeTextField.text!)
        case startPointLongitudeTextField:
            viewModel.validateStartLongituteField(with: startPointLongitudeTextField.text!)
        case finishPointLatitudeTextField:
            viewModel.validateFinishLatitudeField(with: finishPointLatitudeTextField.text!)
        case finishPointLongitudeTextField:
            viewModel.validateFinishLongituteField(with: finishPointLongitudeTextField.text!)
        default:
            return
        }
        
        guard
            let startPointLatitude = startPointLatitudeTextField.text,
                                    !startPointLatitude.isEmpty,
                                    viewModel.isStartLatitudeFilledCorrect,
            let startPointLongitude = startPointLongitudeTextField.text,
                                    !startPointLongitude.isEmpty,
                                    viewModel.isStartLongituteFilledCorrect,
            let finishPointLatitude = finishPointLatitudeTextField.text,
                                    !finishPointLatitude.isEmpty,
                                    viewModel.isFinishLatitudeFilledCorrect,
            let finishPointLongitude = finishPointLongitudeTextField.text,
                                    !finishPointLongitude.isEmpty,
                                    viewModel.isFinishLongituteFilledCorrect
        else {
            calculateDistanceButton.isEnabled = false
            return
        }
        calculateDistanceButton.isEnabled = true
    }
    
    private func setupTextFieldDelegates() {
        startPointLatitudeTextField.delegate = self
        startPointLongitudeTextField.delegate = self
        finishPointLatitudeTextField.delegate = self
        finishPointLongitudeTextField.delegate = self
        
        setPlacehordersForTextFields()
    }
    
    private func setPlacehordersForTextFields() {
        startPointLatitudeTextField.placeholder = "latitude_start_point".localized()
        startPointLongitudeTextField.placeholder = "longitude_start_point".localized()
        finishPointLatitudeTextField.placeholder = "latitude_finish_point".localized()
        finishPointLongitudeTextField.placeholder = "longitude_finish_point".localized()
    }
    
    private func setupButon() {
        calculateDistanceButton.setTitle("calculate_distance".localized(), for: .normal)
        calculateDistanceButton.isEnabled = false
    }
    
    
    // MARK: - Keyboard handling
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY
            let topOfKeyboard = view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if shouldMoveViewUp {
            view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: - UITextField Delegate
extension DistanceCalculationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let aSet = NSCharacterSet(charactersIn:"0123456789.-").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}

// MARK: - DistanceCalculationViewProtocol
extension DistanceCalculationViewController: DistanceCalculationViewProtocol {
    
    func showStartPointInfo(for place: String) {
        DispatchQueue.main.async {
            self.startPointInfoTextView.text = place
        }
    }
    
    func showFinishPointInfo(for place: String) {
        DispatchQueue.main.async {
            self.finishPointInfoTextView.text = place
        }
    }
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        Alert.showAlertOnMainThread(on: self, with: title, message: message)
        
    }
    
    func showIncorrectUserInput(with title: String, message: String) {
        Alert.showAlert(on: self, with: title, message: message)
    }
    
    func showLoadingView() {
        addChild(spinerVC)
        spinerVC.view.frame = view.frame
        view.addSubview(spinerVC.view)
        spinerVC.didMove(toParent: self)
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.spinerVC.willMove(toParent: nil)
            self.spinerVC.view.removeFromSuperview()
            self.spinerVC.removeFromParent()
        }
    }
    
    func setDistanceInKilometers(_ distance: String) {
        distanceInKilometersTitleLabel.text = distance
    }
    
    func setDistanceInMeters(_ distance: String) {
        distanceInMetersTitleLabel.text = distance
    }
}
