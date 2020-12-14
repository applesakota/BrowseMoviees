//
//  Constants.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/9/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Design {
        struct Color {
            static let Gray = UIColor.lightGray
            static let Black = UIColor.black
            static let DarkGray = UIColor.darkGray
            static let White = UIColor.white
            static let GrayCG = Gray.cgColor
            static let DarkGrayCG = DarkGray.cgColor
            static let BlackCG = Black.cgColor
            static let Gray2 = UIColor.systemGray
        }
    }
    struct API {
        static let API_KEY = "5147a0585ac769df0df957cb87b9e605"
        static let BASE_URL = "https://api.themoviedb.org/3"
    }
}
