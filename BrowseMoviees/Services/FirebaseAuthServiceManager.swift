//
//  FirebaseAuthServiceManager.swift
//  BrowseMoviees
//
//  Created by Petar Sakotic on 18.4.22..
//  Copyright © 2022 Petar Sakotic. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


// Private class that will do all FirebaseAuth heavy lifting for us and wrap functionality in single place.
final class FirebaseAuthServiceManager: AuthService {
    
    
    // MARK: - Globals
    
    // Global shared instance should be used inside application.
    static let shared = FirebaseAuthServiceManager()
    
    var handle: AuthStateDidChangeListenerHandle?
    var userAuthorized: Bool { get { return Auth.auth().currentUser != nil } }
    var user = Auth.auth().currentUser
    
    let authVerificationId = "auth_verification_ID"
    
    // MARK: - Constructor
    
    init() {
   
        // Get current user
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            if self.userAuthorized {
                //TODO: Go to home page
                
            } else {
                //TODO: Go to login page
                
            }
        }
        
    }
    
    //MARK: - Public API

    // Registration implementation
    func executeRegister(username: String, password: String, _ callback: @escaping (Result<(), Error>) -> Void) {
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            if let error = error {
                callback(.failure(error))
            } else {
                if let authResult = authResult {
                    let user = authResult.user
                    user.sendEmailVerification { error in
                        if let error = error {
                            callback(.failure(error))
                        } else {
                            callback(.success(()))
                        }
                    }
                }
            }
        }
    }
    
    // Login Implementation
    func executeLogin(username: String, password: String, _ callback: @escaping (Result<(), AuthError>) -> Void) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let _ = error {
                callback(.failure(AuthError.invalidCredentials))
            }
            if let authResult = authResult {
                let user = authResult.user
                if !user.isEmailVerified {
                    callback(.failure(AuthError.userNotVerified))
                } else {
                    callback(.success(()))
                }
            }
            
        }
    }
    
    
    // Resend verification mail implementation
    func executeResendVerificationMail(_ callback: @escaping (Result<(),Error>)->Void) {
        guard let user = Auth.auth().currentUser else { return }
        if !user.isEmailVerified {
            user.sendEmailVerification { error in
                if let error = error {
                    callback(.failure(error))
                } else {
                    callback(.success(()))
                }
            }
        }
    }

    // Logout implementation
    func executeLogout(_ callback: @escaping (Result<(), Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            callback(.success(  () ))
        } catch {
            callback(.failure(error))
        }
    }
    
}

//Auth Error
enum AuthError: Error, LocalizedError {
    case userNotVerified
    case unknown
    case invalidCredentials
    
    public var errorDescription: String? {
        switch self {
        case .userNotVerified:    return "User not verified"
        case .unknown:            return "Unknown"
        case .invalidCredentials: return "invalidCredentials"
        }
    }
}

