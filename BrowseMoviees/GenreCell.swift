//
//  GenreCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {

    @IBOutlet weak var genreImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreCellView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    func configureUI(genre: Genre) {
        genreLabel.text = genre.name
        self.backgroundColor = Constants.Design.Color.BlackColor
        genreLabel.textColor = Constants.Design.Color.WhiteColor
        setImage(for: genre)
        
        
    }
    func setImage(for genre: Genre) {
        if genre.name == "Action" {
            genreImageView.image = UIImage(named: "action")
        } else if genre.name == "Adventure" {
            genreImageView.image = UIImage(named: "adventure")
        } else if genre.name == "Animation" {
            genreImageView.image = UIImage(named: "animation")
        } else if genre.name == "Comedy" {
            genreImageView.image = UIImage(named: "comedy")
        } else if genre.name == "Crime" {
            genreImageView.image = UIImage(named: "crime")
        } else if genre.name == "Family" {
            genreImageView.image = UIImage(named: "family")
        } else if genre.name == "Documentary" {
            genreImageView.image = UIImage(named: "documentary")
        } else if genre.name == "Fantasy" {
            genreImageView.image = UIImage(named: "fantasy")
        } else if genre.name == "History" {
            genreImageView.image = UIImage(named: "history")
        } else if genre.name == "Horror" {
            genreImageView.image = UIImage(named: "horror")
        } else if genre.name == "Music" {
            genreImageView.image = UIImage(named: "music")
        } else if genre.name == "Mystery" {
            genreImageView.image = UIImage(named: "mystery")
        } else if genre.name == "Romance" {
            genreImageView.image = UIImage(named: "romance")
        } else if genre.name == "Science Fiction" {
            genreImageView.image = UIImage(named: "sciencefiction")
        } else if genre.name == "TV Movie" {
            genreImageView.image = UIImage(named: "tvmovie")
        } else if genre.name == "Thriller" {
            genreImageView.image = UIImage(named: "thriller")
        } else if genre.name == "War" {
            genreImageView.image = UIImage(named: "war")
        } else if genre.name == "Western" {
            genreImageView.image = UIImage(named: "western")
        }
    }
    func configureCircle() {
        self.genreCellView.layer.cornerRadius = min(genreCellView.frame.size.height, genreCellView.frame.size.width) / 2.0
        genreCellView.layer.masksToBounds = true
        self.genreCellView.layer.borderColor = Constants.Design.Color.BlackColorCg
        self.genreCellView.layer.borderWidth = 2
        self.genreCellView.backgroundColor = Constants.Design.Color.BlackBacgroundColor
    }

}
