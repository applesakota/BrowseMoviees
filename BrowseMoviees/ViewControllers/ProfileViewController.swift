//
//  ProfileViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileFullNameTextField: UITextField!
    @IBOutlet weak var profilePasswordTextField: UITextField!
    @IBOutlet weak var profileEmailTextField: UITextField!
    @IBOutlet weak var profileDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        userInteraction()
        // Do any additional setup after loading the view.
        
    }
    
    //ui
    func configureUI() {
        view.backgroundColor = Constants.Design.Color.Gray
        self.profileFullNameTextField.delegate = self
        self.profilePasswordTextField.delegate = self
        self.profileEmailTextField.delegate = self
        self.profileDateTextField.delegate = self
        profileFullNameTextField.layer.borderWidth = 2
        profileFullNameTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        
        profilePasswordTextField.layer.borderWidth = 2
        profilePasswordTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        
        profileEmailTextField.layer.borderWidth = 2
        profileEmailTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        
        profileDateTextField.layer.borderWidth = 2
        profileDateTextField.layer.borderColor = Constants.Design.Color.DarkGrayCG
        textFieldsUI()

    }
    func textFieldsUI() {
        profileFullNameTextField.text = UserManager.shared.user?.name
        profilePasswordTextField.text = UserManager.shared.user?.password
        profileEmailTextField.text = UserManager.shared.user?.email
        profileDateTextField.text = UserManager.shared.user?.name
    }
    func userInteraction() {
        profileFullNameTextField.isUserInteractionEnabled = false
        profilePasswordTextField.isUserInteractionEnabled = false
        profileEmailTextField.isUserInteractionEnabled = false
        profileDateTextField.isUserInteractionEnabled = false
    }
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
