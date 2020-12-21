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
    @IBOutlet weak var ratingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configureUI(movie: Movie) {
        var genresString = ""
        for id in movie.genreIds ?? [] {
            if let genre = AppGlobals.shared.genres.first(where: {$0.id == id}) {
                genresString += genre.name + ", "
            }
        }
        if genresString.count > 2 {
            genresString.removeLast()
            genresString.removeLast()
        }
        movieTitleLabel.text = movie.title
        genreLabel.text = genresString
        genreLabel.textColor = Constants.Design.Color.Gray
        movieRatingLabel.text = String(movie.voteAverage ?? 0)
        movieRatingLabel.textColor = Constants.Design.Color.WhiteColor
        movieTitleLabel.textColor = Constants.Design.Color.WhiteColor
        self.backgroundColor = Constants.Design.Color.BlackColor
        self.layer.cornerRadius = 5
        if let backDrop = movie.posterPath,
           let url = URL(string: "\(Constants.API.BASE_IMAGE_URL)/\(ImageSize.original)/\(backDrop)") {
            movieImageView.kf.setImage(with: url)
            movieImageView.layer.cornerRadius = 5
        }
        makeViewCircle()
    }
    
    func makeViewCircle() {
        ratingView.layer.cornerRadius = ratingView.frame.size.width / 2
        ratingView.clipsToBounds = true
        ratingView.layer.borderColor = Constants.Design.Color.RedColorCg
        ratingView.layer.borderWidth = 2
        ratingView.backgroundColor = Constants.Design.Color.BlackColor
    }

    
}
