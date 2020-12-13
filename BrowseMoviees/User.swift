//
//  User.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation


class User: Codable, Equatable {

    var name: String?
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs == rhs
    }
    
}
