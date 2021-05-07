//
//  RegisterViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/9/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit
import Foundation

class RegisterViewController: UIViewController {
    
    let picker = UIDatePicker()
    let toolbar = UIToolbar()
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: UIButton!

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirtdhLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setButtonLabel(labelText: "Already have account? Login", buttonText: "here")
        showDatePicker()
        
    }
    //datePicker
    func showDatePicker() {
        picker.datePickerMode = .date
        toolbar.sizeToFit()
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = picker
    }
    @objc func doneDatePicker() {
        dateOfBirthTextField.text = picker.date.convertToString()
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    func configureUI() {
        view.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        self.fullNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.dateOfBirthTextField.delegate = self
        fullNameTextField.layer.borderWidth = 0
        fullNameTextField.layer.borderColor = Constants.Design.Color.GrayCG
        emailTextField.layer.borderWidth = 0
        emailTextField.layer.borderColor = Constants.Design.Color.GrayCG
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = Constants.Design.Color.GrayCG
        dateOfBirthTextField.layer.borderWidth = 0
        dateOfBirthTextField.layer.borderColor = Constants.Design.Color.GrayCG
        registerButtonUI()
        emailLabel.isHidden = true
        fullNameLabel.isHidden = true
        dateOfBirtdhLabel.isHidden = true
        passwordLabel.isHidden = true
    }
    func setButtonLabel(labelText: String, buttonText: String) {
        helperLabel.text = labelText
        helperLabel.textColor = Constants.Design.Color.WhiteColor
        helperButton.setTitle(buttonText, for: .normal)
    }
    func registerButtonUI() {
        if fullNameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" {
            registerButtonOutlet.layer.borderWidth = 2
            registerButtonOutlet.layer.backgroundColor = Constants.Design.Color.BlackBacgroundColorCg
            registerButtonOutlet.layer.borderColor = Constants.Design.Color.BlackColorCg
            registerButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
            registerButtonOutlet.isUserInteractionEnabled = false
        } else {
            registerButtonOutlet.layer.borderWidth = 0
            registerButtonOutlet.layer.backgroundColor = Constants.Design.Color.RedColorCg
            registerButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
            registerButtonOutlet.isUserInteractionEnabled = true
        }
    }
    //MARK: IBAction
    @IBAction func registerButton(_ sender: Any) {
        AuthenticateManager.shared.createUser(name: fullNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            self.presentError(message: error.localizedDescription)
            
        } successHandler: {
            self.showMainScreen()
        }
    }
}
//MARK: Extensions - TextField
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        registerButtonUI()
        if textField == self.fullNameTextField {
            show(label: fullNameLabel, text: fullNameTextField.placeholder)
            fullNameTextField.placeholder = ""
            
        } else if textField == self.emailTextField {
            show(label: emailLabel, text: emailTextField.placeholder)
            emailTextField.placeholder = ""
            
        } else if textField == self.passwordTextField {
            show(label: passwordLabel, text: passwordTextField.placeholder)
            passwordTextField.placeholder = ""
            
        } else if textField == self.dateOfBirthTextField {
            show(label: dateOfBirtdhLabel, text: "Date:")
            dateOfBirthTextField.placeholder = ""
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        registerButtonUI()
        if textField == self.fullNameTextField {
            hide(label: fullNameLabel)
            fullNameTextField.placeholder = "Full Name"
        } else if textField == self.emailTextField {
            hide(label: emailLabel)
            emailTextField.placeholder = "Email"
            
        } else if textField == self.passwordTextField {
            hide(label: passwordLabel)
            passwordTextField.placeholder = "Password"
            
        } else if textField == self.dateOfBirthTextField {
            hide(label: dateOfBirtdhLabel)
            dateOfBirthTextField.placeholder = "Date of birth"
        }
    }
    func show(label: UILabel, text: String?) {
        label.isHidden = false
        label.text = text
    }
    func hide(label: UILabel) {
        label.isHidden = true
    }
    
}
