//
//  ViewController.swift
//  Lab-4
//
//  Created by Naitik Ratilal Patel on 27/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextFieldDelegates()
    }
    
    @IBAction func resetDidTapped(_ sender: UIButton) {
        clearAllTheFields(isDeclineTapped: false)
    }
    
    @IBAction func declineDidTapped(_ sender: UIButton) {
        clearAllTheFields(isDeclineTapped: true)
    }
    
    @IBAction func acceptDidTapped(_ sender: UIButton) {
        
        warningLabel.isHidden = true
        
        if isAllTheFieldsCompleted() {
            if let age = calculateAge() {
                if age > 18 {
                    outputTextView.text = "I, \(firstNameTextField.text!) \(surnameTextField.text!), currently living at \(addressTextField.text!) in the city of \(cityTextField.text!) do hereby accept the terms and conditions os this assignment."
                    
                    outputTextView.text += "\n\nI am \(age) and therefore able to accept the terms and conditions of this assignment"
                } else {
                    warningLabel.text = "You are under 18 so, not able to accept the terms and conditions of this assignment."
                    warningLabel.isHidden = false
                }
            } else {
                warningLabel.text = "Please provide birth date in valid formate of dd/mm/yyyy."
                warningLabel.isHidden = false
            }
        } else {
            warningLabel.text = "Please fill up all the required details!"
            warningLabel.isHidden = false
        }
    }
    
    private func setupView() {
        outputTextView.layer.borderWidth = 1
        outputTextView.layer.borderColor = UIColor.black.cgColor
        outputTextView.layer.cornerRadius = 10
        
        warningLabel.isHidden = true
    }
    
    private func setupTextFieldDelegates() {
        firstNameTextField.delegate = self
        surnameTextField.delegate = self
        addressTextField.delegate = self
        cityTextField.delegate = self
        dateOfBirthTextField.delegate = self
    }
    
    private func clearAllTheFields(isDeclineTapped: Bool) {
        firstNameTextField.text = ""
        surnameTextField.text = ""
        addressTextField.text = ""
        cityTextField.text = ""
        dateOfBirthTextField.text = ""
        outputTextView.text = isDeclineTapped ? "User has declined!" : ""
        warningLabel.isHidden = true
    }
    
    private func isAllTheFieldsCompleted() -> Bool {
        return (firstNameTextField.text != "" && surnameTextField.text != "" && addressTextField.text != "" && cityTextField.text != "" && dateOfBirthTextField.text != "")
    }
    
    private func calculateAge() -> Int? {
        if let dateOfBirthStr = dateOfBirthTextField.text {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if let dateOfBirth = dateFormatter.date(from: dateOfBirthStr) {
                let calender = Calendar.current
                let currentDate = Date()
                let calculatedAge = calender.dateComponents([.year], from: dateOfBirth, to: currentDate)
                return calculatedAge.year
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        warningLabel.isHidden = true
    }
}
