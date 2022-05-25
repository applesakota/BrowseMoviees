//
//  BrowseMoviesTextField.swift
//  BrowseMoviees
//
//  Created by Petar Sakotic on 25.5.22..
//  Copyright © 2022 Petar Sakotic. All rights reserved.
//

import UIKit

final class BrowseMoviesTextField: UIView, UITextFieldDelegate {

    class var nibName: String { return "BrowseMoviesTextField" }
    
    @IBOutlet weak var view: UIView!
    
    struct Config {
        var title: String?
        var placeholder: String?
        var isSecureTextEntry: Bool
        var titleColor: UIColor
        var selectedColor: UIColor
        var iconColor: UIColor
        var keyboardType: UIKeyboardType
        var keyboardAppearance: UIKeyboardAppearance
        var returnKeyType: UIReturnKeyType
        var textValidityExpression: ((String) -> (Bool, String?))? = nil
        var returnKeyCallback: (()->Swift.Void)? = nil
        var shouldBeginEditingCallback: (()->Bool)? = nil
        var endEditingCallback: (()->Swift.Void)? = nil
        var textShouldChangeCallback: ((String) -> Bool)? = nil
        
        static var empty: Config {
            return Config(
                title: "",
                placeholder: "",
                isSecureTextEntry: false,
                titleColor: .clear,
                selectedColor: .clear,
                iconColor: .clear,
                keyboardType: .default,
                keyboardAppearance: .default,
                returnKeyType: .default
            )
        }
    }
    
    private(set) var config: Config = Config.empty
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var revealPasswordButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - Constructors
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.nibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetup()
    }
    
    convenience init(frame: CGRect, config: Config) {
        self.init(frame: frame)
        self.configuration(with: config)
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        insertSubview(view, at: 0)
        
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: BrowseMoviesTextField.nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func configuration(with config: Config) {
        self.config = config
        
        iconImageView.isHidden = true
        revealPasswordButton.isHidden = !config.isSecureTextEntry
        revealPasswordButton.tintColor = config.iconColor
        
        titleLabel.text = config.title
        titleLabel.isHidden = (config.title == nil)
        titleLabel.textColor = config.titleColor
        
        textField.placeholder = config.placeholder
        textField.isSecureTextEntry = config.isSecureTextEntry
        textField.keyboardType = config.keyboardType
        textField.keyboardAppearance = config.keyboardAppearance
        textField.returnKeyType = config.returnKeyType
        textField.overrideUserInterfaceStyle = .light
    }
    
    //MARK: - User Interaction
    
    @IBAction func revealPasswordButtonTouched(_ sender: Any) {
        self.textField.isSecureTextEntry = !self.textField.isSecureTextEntry
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleLabel.textColor = config.selectedColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        iconImageView.isHidden = true
        errorLabel.isHidden = true
        if let callback = config.textShouldChangeCallback, let text = textField.text, let textRange = Range(range, in: text) {
            let newText = text.replacingCharacters(in: textRange, with: string)
            return callback(newText)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        config.returnKeyCallback?()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        titleLabel.textColor = config.titleColor
        config.endEditingCallback?()
    }
    
    func checkTextValidity() -> Bool {
        if let textValidityExpression = config.textValidityExpression {
            if let text = textField.text {
                let (isValid, errorMessage) = textValidityExpression(text)
                if isValid {
                    iconImageView.tintColor = config.iconColor
                    iconImageView.image = UIImage(systemName: "checkmark")
                    iconImageView.isHidden = false
                    errorLabel.text = nil
                    return true
                } else {
                    iconImageView.tintColor = UIColor.red
                    iconImageView.image = UIImage(systemName: "xmark")
                    iconImageView.isHidden = false
                    errorLabel.isHidden = false
                    errorLabel.text = errorMessage
                }
            }
            return false
        }
        return true
    }
}
