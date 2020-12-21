//
//  UserManager.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
enum UserManagerError: Error {
    case noMovie
}

class UserManager {
    
    static let shared = UserManager()
    private init() {}
    static let userMoviesChangedNotificationName = "moviesChanged"
    var user: User? {
        didSet {
            UserDefaults.standard.set(self.user != nil, forKey: UserManager.userDefaultKey)
            UserDefaults.standard.set(self.user?.name, forKey: UserManager.userDefaultNameKey)
            UserDefaults.standard.set(self.user?.email, forKey: UserManager.userDefaultEmailKey)
            UserDefaults.standard.set(self.user?.password, forKey: UserManager.userDefaultPasswordKey)
            UserDefaults.standard.set(self.user?.movies, forKey: UserManager.userDefaultMoviesKey)
            UserDefaults.standard.setValue(true, forKey: UserManager.userDefaultIsLogin)
        }
    }
    private static let userDefaultMoviesKey = "userDefaultMoviesKey"
    private static let userDefaultKey = "userDefaultKey"
    private static let userDefaultNameKey = "userDefaulNameKey"
    private static let userDefaultEmailKey = "userDefaulEmailKey"
    private static let userDefaultPasswordKey = "userDefaultPasswordKey"
    private static let userDefaultIsLogin = "userDefaultIsLogin"
    
    func logOut() {
        UserDefaults.standard.setValue(false, forKey: UserManager.userDefaultIsLogin)
    }
    func logIn() {
        UserDefaults.standard.setValue(true, forKey: UserManager.userDefaultIsLogin)
    }
    
    func initUser(name: String, email:String, password:String, isLogin: Bool) {
        let userFromUserDefaults = User(name: name, email: email, password: password, isLogin: isLogin)
        user = userFromUserDefaults
    }
    func getLastSignUser() -> User? {
        if let name = UserDefaults.standard.string(forKey: UserManager.userDefaultNameKey),
           let email = UserDefaults.standard.string(forKey: UserManager.userDefaultEmailKey),
           let password = UserDefaults.standard.string(forKey: UserManager.userDefaultPasswordKey) {
            initUser(name: name, email: email, password: password, isLogin: UserDefaults.standard.bool(forKey: UserManager.userDefaultIsLogin))
        }
        return user
    }
    func addMovie(movie: Movie?, successHandler: ()->Void, errorHandler: (_ error: Error) -> Void) {
        if movie != nil {
            user?.movies?.append(movie!)
            NotificationCenter.default.post(name: NSNotification.Name(UserManager.userMoviesChangedNotificationName), object: nil)
            successHandler()
        } else {
            errorHandler(UserManagerError.noMovie)
        }
    }
}
