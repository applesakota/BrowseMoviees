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
            static let Red = UIColor.systemRed
            static let RedColor = UIColor(hexString: "#db0000")
            static let RedColorCg = RedColor.cgColor
            static let BlackColor = UIColor(hexString: "#000000")
            static let BlackColorCg = BlackColor.cgColor
            static let WhiteColor = UIColor(hexString: "#ffffff")
            static let WhiteColorCg = WhiteColor.cgColor
            static let BlackLightColor = UIColor(hexString: "#564D4D")
            static let BlackLightColorCg = BlackLightColor.cgColor
            static let RedLightColor = UIColor(hexString: "#831010")
            static let RedLightColorCg = RedLightColor.cgColor
            static let BlackBacgroundColor = UIColor(hexString: "221F1F")
            static let BlackBacgroundColorCg = BlackBacgroundColor.cgColor
        }
    }
    struct API {
        static let API_KEY = "5147a0585ac769df0df957cb87b9e605"
        static let BASE_URL = "https://api.themoviedb.org/3"
        static let BASE_IMAGE_URL = "https://image.tmdb.org/t/p"
    }
}
