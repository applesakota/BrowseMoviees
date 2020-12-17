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
    @IBOutlet weak var logoutButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //userInteraction()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(saveUser), imageName: "save-button")
    }
    @objc func saveUser() {
        AuthenticateManager.shared.editUser(name: profileFullNameTextField.text ?? "", email: profileEmailTextField.text ?? "", password: profilePasswordTextField.text ?? "") { (error) in
            self.presentError(message: error.localizedDescription)
        } successHandler: {
            self.presentComplete()
        }
    }
    func presentComplete() {
        let alert = UIAlertController(title: "Nice", message: "Success save your details", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func presentReminder() {
        let alert = UIAlertController(title: "Are you sure to logout", message: "Your data will be lost", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            UserManager.shared.user = nil
            self.showLoginScreen()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
        
        logoutButtonOutlet.layer.backgroundColor = Constants.Design.Color.BlackCG
        logoutButtonOutlet.setTitleColor(Constants.Design.Color.White, for: .normal)
        
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
    //MARK: -Actions
    @IBAction func logoutButtonTapped(_ sender: Any) {
        presentReminder()
    }
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
