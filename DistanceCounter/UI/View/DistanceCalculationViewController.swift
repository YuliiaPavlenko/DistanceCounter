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
    
    @IBAction func startPointLatitudeTextFieldIsActive(_ sender: Any) {
        viewModel.checkIfLatitudeIsCorrect(userInput: startPointLatitudeTextField.text!)
    }
    
    @IBAction func startPointLongitudeTextFieldIsActive(_ sender: Any) {
        viewModel.checkIfLongitudeIsCorrect(userInput: startPointLongitudeTextField.text!)
    }
    
    @IBAction func finishPointLatitudeTextFieldIsActive(_ sender: Any) {
        viewModel.checkIfLatitudeIsCorrect(userInput: startPointLatitudeTextField.text!)
    }
    
    @IBAction func finishPointLongitudeTextFieldIsActive(_ sender: Any) {
        viewModel.checkIfLongitudeIsCorrect(userInput: startPointLongitudeTextField.text!)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self

        setupTextFieldDelegates()
        addKeyboardObservers()
    }
    
    private func setupTextFieldDelegates() {
        startPointLatitudeTextField.delegate = self
        startPointLongitudeTextField.delegate = self
        finishPointLatitudeTextField.delegate = self
        finishPointLongitudeTextField.delegate = self
        
        setPlacehordersForTextFields()
    }
    
    private func setPlacehordersForTextFields() {
        startPointLatitudeTextField.placeholder = "Latitude of start point"
        startPointLongitudeTextField.placeholder = "Longitude of start point"
        finishPointLatitudeTextField.placeholder = "Latitude of finish point"
        finishPointLongitudeTextField.placeholder = "Longitude of finish point"
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
    func updateUI(with: Place) {
    
    }
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        Alert.showAlertOnMainThread(on: self, with: title, message: message)
    }
    
    func showIncorrectUserInput(with title: String, message: String) {
        Alert.showAlert(on: self, with: title, message: message)
    }
}
