//
//  UserManager.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    private init() {}
    var user: User? {
        didSet {
            UserDefaults.standard.set(self.user != nil, forKey: UserManager.userDefaultKey)
            UserDefaults.standard.set(self.user?.name, forKey: UserManager.userDefaultNameKey)
            UserDefaults.standard.set(self.user?.email, forKey: UserManager.userDefaultEmailKey)
            UserDefaults.standard.set(self.user?.password, forKey: UserManager.userDefaultPasswordKey)
        }
    }
    private static let userDefaultKey = "userDefaultKey"
    private static let userDefaultNameKey = "userDefaulNameKey"
    private static let userDefaultEmailKey = "userDefaulEmailKey"
    private static let userDefaultPasswordKey = "userDefaultPasswordKey"
    var isLogin: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserManager.userDefaultKey)
        }
    }
    func initUser(name: String, email:String, password:String) {
        let userFromUserDefaults = User(name: name, email: email, password: password)
        user = userFromUserDefaults
    }
    func getLastSignUser() -> User? {
        if isLogin,
           let name = UserDefaults.standard.string(forKey: UserManager.userDefaultNameKey),
           let email = UserDefaults.standard.string(forKey: UserManager.userDefaultEmailKey),
           let password = UserDefaults.standard.string(forKey: UserManager.userDefaultPasswordKey) {
            initUser(name: name, email: email, password: password)
        }
        return user
    }
}
