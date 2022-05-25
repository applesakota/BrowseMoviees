//
//  AuthService.swift
//  BrowseMoviees
//
//  Created by Petar Sakotic on 18.4.22..
//  Copyright © 2022 Petar Sakotic. All rights reserved.
//

import Foundation
import Firebase

// AuthService will contain all authentication functions that we need.
protocol AuthService {
    
    /// Registration function that should sign up a new user.
    /// - Parameters:
    ///    - username: Username(email).
    ///    - password: User password
    ///    - callback: Callback function will be async executed once request is done.
    func executeRegister(username: String, password: String, _ callback: @escaping (Result<(),Error>)->Swift.Void)
    
    
    /// Logut function that should logout user from the app.
    ///  - Parameters:
    ///     - callback: Callback function will be async executed once request is done.
    func executeLogout(_ callback: @escaping (Result<(),Error>)->Swift.Void)
    
    
    /// Login function that should try to log in existing user.
    ///  - Parameters:
    ///     - username: Username(email).
    ///     - password: User password
    ///     - callback: Callback function will be async executed once request is done
    func executeLogin(username: String, password: String, _ callback: @escaping (Result<(),AuthError>)->Swift.Void)
    
    
    /// Resend Verification functiont that should resend verification email.
    /// - Parameters:
    ///  - callback: Callback function will be async executed once request is done
    func executeResendVerificationMail(_ callback: @escaping (Result<(),Error>)->Swift.Void)
    
}
