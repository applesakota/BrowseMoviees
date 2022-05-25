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
    
    //MARK: - Globals
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: UIButton!

    @IBOutlet weak var emailTextField: BrowseMoviesTextField!
    @IBOutlet weak var passwordTextField: BrowseMoviesTextField!
    
    var user: User?
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setButtonLabel(labelText: "Don't have an account? Register", buttonText: "here")
    }
    
    // MARK: - Utils
    
    func configureUI() {
        view.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        
        let titleColor = Constants.Design.Color.WhiteColor
        let selectedColor = Constants.Design.Color.WhiteColor
        let iconColor = Constants.Design.Color.DarkGray
        
        emailTextField.configuration(with: BrowseMoviesTextField.Config(
            title: "Email",
            placeholder: "example@example.com",
            isSecureTextEntry: false,
            titleColor: titleColor,
            selectedColor: selectedColor,
            iconColor: iconColor,
            keyboardType: .emailAddress,
            keyboardAppearance: .default,
            returnKeyType: .next,
            textValidityExpression: { text in
                return (text.trimmingAllSpaces.isValidEmail, "Email is not valid")
            },
            returnKeyCallback: { [weak self] in
                self?.passwordTextField.textField.becomeFirstResponder()
            }))
        
        passwordTextField.configuration(with: BrowseMoviesTextField.Config(
            title: "Password",
            placeholder: "Password",
            isSecureTextEntry: true,
            titleColor: titleColor,
            selectedColor: selectedColor,
            iconColor: iconColor,
            keyboardType: .default,
            keyboardAppearance: .default,
            returnKeyType: .continue,
            textValidityExpression: { text in
                return (text.trimmingAllSpaces.isValidPassword, "Password should countain 8 characters at least 1 alphabet and 1 number")
            },
            returnKeyCallback: { [weak self] in
                self?.passwordTextField.resignFirstResponder()
                self?.loginButtonOutlet.sendActions(for: .touchUpInside)
            }))
        
        self.loginButtonOutlet.backgroundColor = Constants.Design.Color.RedColor
        self.loginButtonOutlet.isUserInteractionEnabled = true
        self.loginButtonOutlet.tintColor = Constants.Design.Color.DarkGray
    }
        
                                
    func setButtonLabel(labelText: String, buttonText: String) {
        helperLabel.text = labelText
        helperLabel.textColor = Constants.Design.Color.WhiteColor
        helperButton.setTitle(buttonText, for: .normal)
    }
    
    func isValidInput() -> Bool {
        let flag1 = emailTextField.checkTextValidity()
        let flag2 = passwordTextField.checkTextValidity()
        
        return flag1 && flag2
    }
    
    //MARK: - User Interaction
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if isValidInput() {
            apiLogin(username: emailTextField.textField.text ?? "", password: passwordTextField.textField.text ?? "")
        }
        
//        AuthenticateManager.shared.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", errorHandler: { (error) in
//            self.presentError(message: AuthenticateManagerError.emailError.localizedDescription)
//        }, successHandler: {
//            UserManager.shared.logIn()
//            self.showMainScreen()
//        })
    }
    
    @discardableResult
    func presentResendVerificationAlert(message: String) -> (alert: UIAlertController, actions: [MoviesAlertAction]) {
        return presentAlert(message: message, actions: [
            MoviesAlertAction(title: "Resend verification email", handler: { self.apiResendVerification() }),
            MoviesAlertAction(title: "Cancel", handler: nil)
        ])
        
    }
    
    
    //MARK: - API
    
    private func apiLogin(username: String, password: String) {
        
        AppGlobals.firebaseService.login(username: username, password: password) { result in
            switch result {
            case .success: self.showMainScreen()
            case .failure(let error):
                if error == .userNotVerified {
                    self.presentResendVerificationAlert(message: error.localizedDescription)
                } else {
                    self.presentError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func apiResendVerification() {
        AppGlobals.firebaseService.resendVerificationMail { result in
            switch result {
            case .success: self.presentError(message: "Verificetion mail sent")
            case .failure(let error): self.presentError(message: error.localizedDescription)
            }
        }
    }
    
}

