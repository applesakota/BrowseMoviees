//
//  FoundationExtensions.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/17/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
}
