//
//  RegisterViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/9/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setButtonLabel(labelText: "Already have account? Login", buttonText: "here")
    }
    func configureUI() {
        view.backgroundColor = Constants.Design.Color.Gray
        self.fullNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.dateOfBirthTextField.delegate = self
        fullNameTextField.layer.borderWidth = 2
        fullNameTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        dateOfBirthTextField.layer.borderWidth = 2
        dateOfBirthTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        registerButtonOutlet.layer.backgroundColor = Constants.Design.Color.BlackCG
        registerButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
    }
    func setButtonLabel(labelText: String, buttonText: String) {
        helperLabel.text = labelText
        helperLabel.textColor = Constants.Design.Color.DarkGray
        helperButton.setTitle(buttonText, for: .normal)
    }
    //MARK: IBAction
    @IBAction func registerButton(_ sender: Any) {
        AuthenticateManager.shared.createUser(name: fullNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            self.presentError(message: error.localizedDescription)
            
        } successHandler: {
            print(UserManager.shared.user?.name)
        }
    }
}
//MARK: Extensions - TextField
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
