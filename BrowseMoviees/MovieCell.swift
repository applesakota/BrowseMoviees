//
//  MovieCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    func configureUI(movie: Movie) {
        movieTitleLabel.text = movie.title
        genreLabel.text = movie.title
        movieTitleLabel.textColor = Constants.Design.Color.DarkGray
        self.backgroundColor = Constants.Design.Color.Gray
    }
    
}
