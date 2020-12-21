//
//  MovieDetailCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit
import Kingfisher

protocol MyCollectionViewCellDelegate: AnyObject {
    func didTapButton(with movie: Movie)
}

class MovieDetailCell: UITableViewCell {
    
    weak var delegate: MyCollectionViewCellDelegate?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var movieTextView: UITextView!
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addToMyListButton: UIButton!
    
    let shapeLayer = CAShapeLayer()
    var movieRating: Double = 10.0
    var percentage: Double?
    var movie: Movie?
    
    func configureUI(movie: Movie) {
        self.movie = movie
        playButton.backgroundColor = Constants.Design.Color.RedColor
        addToMyListButton.backgroundColor = Constants.Design.Color.WhiteColor
        playButton.layer.cornerRadius = 5
        addToMyListButton.layer.cornerRadius = 5
        var ganresString = ""
        movieTitleLabel.text = movie.title
        movieTitleLabel.textColor = Constants.Design.Color.WhiteColor
        for id in movie.genreIds ?? []{
            if let genre = AppGlobals.shared.genres.first(where: {$0.id == id}) {
                ganresString += genre.name + ", "
            }
        }
        if ganresString.count > 2 {
            ganresString.removeLast()
            ganresString.removeLast()
        }
        percentage = (movie.voteAverage ?? 0) / movieRating
        genreLabel.text = ganresString
        genreLabel.textColor = Constants.Design.Color.WhiteColor
        ratingLabel.text = ""
        ratingLabel.textColor = Constants.Design.Color.WhiteColor
        ratingNumberLabel.text = String(movie.voteAverage ?? 0)
        ratingNumberLabel.textColor = Constants.Design.Color.WhiteColor
        movieTextView.text = movie.overview
        movieTextView.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        movieTextView.textColor = Constants.Design.Color.WhiteColor
        self.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        if let backDrop = movie.backdropPath,
           let url = URL(string: "\(Constants.API.BASE_IMAGE_URL)/\(ImageSize.original)/\(backDrop)") {
            movieImageView.kf.setImage(with: url)
        }
        makeCircleLayer()
        
    }
    

    //Animation
    func makeCircleLayer() {
        viewOutlet.backgroundColor = .clear
        //track
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(ovalIn: viewOutlet.bounds)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = Constants.Design.Color.BlackColorCg
        trackLayer.lineWidth = 5
        trackLayer.fillColor = Constants.Design.Color.BlackColorCg
        trackLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        viewOutlet.layer.addSublayer(trackLayer)
        //shape
        shapeLayer.path = circularPath.cgPath
        shapeLayer.backgroundColor = Constants.Design.Color.White.cgColor
        shapeLayer.strokeColor = Constants.Design.Color.Red.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = Constants.Design.Color.BlackBacgroundColorCg
        shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        shapeLayer.strokeEnd = 0
        viewOutlet.layer.addSublayer(shapeLayer)
        ratingNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingNumberLabel.centerXAnchor.constraint(equalTo: viewOutlet.centerXAnchor).isActive = true
        ratingNumberLabel.centerYAnchor.constraint(equalTo: viewOutlet.centerYAnchor).isActive = true
        ratingNumberLabel.textAlignment = .center
        viewOutlet.addSubview(ratingNumberLabel)
        animateStroke()
    }
    func animateStroke() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = percentage
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    @IBAction func addToMyListAction(_ sender: UIButton) {
        delegate?.didTapButton(with: movie!)
    }
}
