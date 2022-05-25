//
//  AppGlobals.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/18/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation


class AppGlobals {
    
    /// Global instance of firebase service
    static let firebaseService = FirebaseAuthManager.shared
    
    static let shared = AppGlobals()
    var genres: [Genre] = []
    
    private init() {
        
    }
}
