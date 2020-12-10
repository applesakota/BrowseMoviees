//
//  AuthenticateManager.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
import UIKit

enum AuthenticateManagerError: Error {
    case passwordIsEmpty
    case passwordMustContainSpecialCaracters
    case nameIsEmpty
    case nameMustContainsCharacters
    case emailError
    case errorSavingUser
}
extension AuthenticateManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .passwordIsEmpty:
            return NSLocalizedString("Password cannot be empty", comment: "")
        case .passwordMustContainSpecialCaracters:
            return NSLocalizedString("Password must contain special caracters", comment: "")
        case .nameIsEmpty:
            return NSLocalizedString("Name cannot be empty", comment: "")
        case .nameMustContainsCharacters:
            return NSLocalizedString("Name must contain special caracters", comment: "")
        case .emailError:
            return NSLocalizedString("Email not valid", comment: "")
        case .errorSavingUser:
            return NSLocalizedString("Error saving user", comment: "")
        }
    }
}


class AuthenticateManager {
    static let shared = AuthenticateManager()
    
    func createUser(name: String, email: String, password: String, errorHandler: @escaping ErrorHandler, successHandler: @escaping ()->Void) {
        if let error = validateName(name: name) {
            errorHandler(error)
            return
        }
        if isPasswordValid(password: password) != nil {
            errorHandler(AuthenticateManagerError.passwordIsEmpty)
            return
        }
        if let error = validateEmail(email: email) {
            errorHandler(error)
            return
        }
        if saveToUserDefaults(name: name, email: email, password: password) {
            successHandler()
        } else {
            errorHandler(AuthenticateManagerError.errorSavingUser)
            return
        }
    }
    private func validateName(name: String) -> AuthenticateManagerError? {
        if name.isEmpty {
            return AuthenticateManagerError.nameIsEmpty
        } else if name.trimmingCharacters(in: .whitespaces).isEmpty {
            return AuthenticateManagerError.passwordMustContainSpecialCaracters
        }
        return nil
    }
    private func isPasswordValid(password: String) -> Error? {
        if password.isEmpty {
            return AuthenticateManagerError.passwordIsEmpty
        }
        return nil
    }
    private func validateEmail(email: String) -> AuthenticateManagerError? {
        if validateEmailAddress(email: email) != true {
            return AuthenticateManagerError.emailError
        }
        return nil
    }
    private func validateEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func saveToUserDefaults(name: String, email:String, password: String) -> Bool {
        if UserManager.shared.getLastSignUser() != nil {
            UserManager.shared.initUser(name: name, email: email, password: password)
            return true
        }
        return false
    }
}
