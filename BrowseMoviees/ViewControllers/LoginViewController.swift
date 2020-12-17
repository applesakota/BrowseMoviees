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
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setButtonLabel(labelText: "Don't have an account? Register", buttonText: "here")
    }
    
    //UI
    func configureUI() {
        view.backgroundColor = Constants.Design.Color.Gray
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        loginButtonOutlet.layer.backgroundColor = Constants.Design.Color.BlackCG
        loginButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
        if user != nil {
            emailTextField.text = user?.email
            passwordTextField.text = user?.password
        }
        
    }
    func setButtonLabel(labelText: String, buttonText: String) {
        helperLabel.text = labelText
        helperLabel.textColor = Constants.Design.Color.DarkGray
        helperButton.setTitle(buttonText, for: .normal)
    }
    
    //MARK: -Actions
    @IBAction func loginButtonAction(_ sender: Any) {
        AuthenticateManager.shared.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", errorHandler: { (error) in
            self.presentError(message: AuthenticateManagerError.emailError.localizedDescription)
        }, successHandler: {
            UserManager.shared.isLogin(value: true)
            self.showMainScreen()
        })
    }
}
    extension LoginViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    }
