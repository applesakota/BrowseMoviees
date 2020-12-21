//
//  CastMovieCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit
import Kingfisher

class CastMovieCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    
    
    func configureUI(credits: Cast)  {
        movieNameLabel.text = credits.character
        realNameLabel.text = credits.originalName
        realNameLabel.textColor = Constants.Design.Color.WhiteColor
        movieNameLabel.textColor = Constants.Design.Color.WhiteColor
        if let profilePath = credits.profilePath,
           let url = URL(string: "\(Constants.API.BASE_IMAGE_URL)/\(ImageSize.original)/\(profilePath)") {
         castImageView.kf.setImage(with: url)
        }
        configureImageCircular()
        self.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        self.isUserInteractionEnabled = false
    }
    func configureImageCircular() {
        
    }
}
