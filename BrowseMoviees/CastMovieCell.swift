//
//  CastMovieCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class CastMovieCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    
    func configureUI()  {
        movieNameLabel.text = "Movie name"
        realNameLabel.text = "Real name"
        realNameLabel.textColor = Constants.Design.Color.DarkGray
        movieNameLabel.textColor = Constants.Design.Color.DarkGray
        self.backgroundColor = Constants.Design.Color.Gray
        self.isUserInteractionEnabled = false
    }

}
