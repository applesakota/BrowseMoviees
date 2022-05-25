//
//  FirebaseAuthManager.swift
//  BrowseMoviees
//
//  Created by Petar Sakotic on 24.4.22..
//  Copyright © 2022 Petar Sakotic. All rights reserved.
//

import Foundation


class FirebaseAuthManager {
    
    // MARK: - Globals
    
    // Global shared instance should be used inside application
    static let shared = FirebaseAuthManager(service: FirebaseAuthServiceManager.shared)
    
    // Firebase service provider
    let service: AuthService
    
    // MARK: - Init
    
    init(service: AuthService) {
        self.service = service
    }
    
    /// Registration function that should sign up a new user.
    /// - Parameters:
    ///    - username: Username(email).
    ///    - password: User password
    ///    - callback: Callback function will be async executed once request is done.
    func register(username: String, password: String, _ callback: @escaping (Result<(),Error>)->Swift.Void ) {
        service.executeRegister(username: username, password: password) { result in
            switch result {
            case .success: callback(.success( () ))
            case .failure(let error): callback(.failure(error))
            }
        }
    }

    /// Login function that should try to log in existing user.
    ///  - Parameters:
    ///     - username: Username(email).
    ///     - password: User password
    ///     - callback: Callback function will be async executed once request is done
    func login(username: String, password: String, callback: @escaping (Result<(),AuthError>)->Swift.Void) {
        service.executeLogin(username: username, password: password) { result in
            switch result {
            case .success: callback(.success( () ))
            case .failure(let error): callback(.failure(error))
            }
        }
    }
    
    func getCurrentUser() {
        
    }
    
    /// Resend Verification functiont that should resend verification email.
    /// - Parameters:
    ///  - callback: Callback function will be async executed once request is done
    func resendVerificationMail( _ callback: @escaping (Result<(),Error>)->Swift.Void ) {
        service.executeResendVerificationMail { result in
            switch result {
            case .success: callback(.success(()))
            case .failure(let error): callback(.failure(error))
            }
        }
    }

    /// Logut function that should logout user from the app.
    ///  - Parameters:
    ///     - callback: Callback function will be async executed once request is done.
    func logout(_ callback: @escaping (Result<(),Error>)->Swift.Void) {
        service.executeLogout { result in
            switch result {
            case .success: callback(.success(()))
            case .failure(let error): callback(.failure(error))
            }
        }
    }
    
    
}
