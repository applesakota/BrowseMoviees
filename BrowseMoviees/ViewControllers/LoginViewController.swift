//
//  LoginViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setButtonLabel(labelText: "Don't have an account? Register", buttonText: "here")
    }
    
    //UI
    func configureUI() {
        view.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        emailTextField.layer.borderWidth = 0
        emailTextField.layer.borderColor = Constants.Design.Color.GrayCG
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = Constants.Design.Color.GrayCG
        registerButtonUI()
        if user != nil {
            emailTextField.text = user?.email
            passwordTextField.text = user?.password
        }
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        
    }
    func registerButtonUI() {
        if emailTextField.text == "" || passwordTextField.text == "" {
            loginButtonOutlet.layer.borderWidth = 2
            loginButtonOutlet.layer.backgroundColor = Constants.Design.Color.BlackBacgroundColorCg
            loginButtonOutlet.layer.borderColor = Constants.Design.Color.BlackColorCg
            loginButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
            loginButtonOutlet.isUserInteractionEnabled = false
        } else {
            loginButtonOutlet.layer.borderWidth = 0
            loginButtonOutlet.layer.backgroundColor = Constants.Design.Color.RedColorCg
            loginButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
            loginButtonOutlet.isUserInteractionEnabled = true
        }
    }
    func setButtonLabel(labelText: String, buttonText: String) {
        helperLabel.text = labelText
        helperLabel.textColor = Constants.Design.Color.WhiteColor
        helperButton.setTitle(buttonText, for: .normal)
    }
    
    //MARK: -Actions
    @IBAction func loginButtonAction(_ sender: Any) {
        AuthenticateManager.shared.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", errorHandler: { (error) in
            self.presentError(message: AuthenticateManagerError.emailError.localizedDescription)
        }, successHandler: {
            UserManager.shared.logIn()
            self.showMainScreen()
        })
    }
}
    extension LoginViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            registerButtonUI()
            self.view.endEditing(true)
            return false
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            registerButtonUI()
            if textField == self.emailTextField {
                show(label: emailLabel, text: emailTextField.placeholder)
                emailTextField.placeholder = ""
                
            } else if textField == self.passwordTextField {
                show(label: passwordLabel, text: passwordTextField.placeholder)
                passwordTextField.placeholder = ""
            }
            
        }
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            registerButtonUI()
            if textField == self.emailTextField {
                hide(label: emailLabel)
                emailTextField.placeholder = "Email"
            } else if textField == self.passwordTextField {
                hide(label: passwordLabel)
                passwordTextField.placeholder = "Password"
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
