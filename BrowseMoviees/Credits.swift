//
//  Credits.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/14/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation

struct CreditsList: Codable {
    let id: Int?
    let cast: [Cast]?
}
struct Cast: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case creditId = "credit_id"
        case adult,gender,id,name,popularity,character,order
    }
}
