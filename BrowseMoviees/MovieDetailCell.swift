//
//  MovieDetailCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var movieTextView: UITextView!
    
    
    func configureUI(movie: Movie) {
        movieTitleLabel.text = movie.title
        movieTitleLabel.textColor = Constants.Design.Color.DarkGray
        genreLabel.text = "Genre"
        genreLabel.textColor = Constants.Design.Color.DarkGray
        ratingLabel.text = "Rating: "
        ratingLabel.textColor = Constants.Design.Color.DarkGray
        ratingNumberLabel.text = String(movie.voteAverage ?? 0)
        ratingNumberLabel.textColor = Constants.Design.Color.DarkGray
        movieTextView.text = movie.overview
        movieTextView.backgroundColor = Constants.Design.Color.Gray
        movieTextView.textColor = Constants.Design.Color.DarkGray
        self.backgroundColor = Constants.Design.Color.Gray
        
    }

}
