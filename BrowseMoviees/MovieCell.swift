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
    
    let shapeLayer = CAShapeLayer()
    var movieRating: Double = 10.0
    var percentage: Double?
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
        percentage = (movie.voteAverage ?? 0) / movieRating
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
        makeCircleLayer()

    }
    func makeCircleLayer() {
        ratingView.backgroundColor = .clear
        //track
        let trackLayer = CAShapeLayer()
        let center = CGPoint(x: ratingView.bounds.width / 2, y: ratingView.bounds.height / 2)
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 22, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = Constants.Design.Color.BlackColorCg
        trackLayer.lineWidth = 5
        trackLayer.fillColor = Constants.Design.Color.BlackColorCg
        trackLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        trackLayer.position = center
        ratingView.layer.addSublayer(trackLayer)
        //shape
        shapeLayer.path = circularPath.cgPath
        shapeLayer.backgroundColor = Constants.Design.Color.White.cgColor
        shapeLayer.strokeColor = Constants.Design.Color.Red.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = Constants.Design.Color.BlackBacgroundColorCg
        shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        shapeLayer.strokeEnd = 0
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        ratingView.layer.addSublayer(shapeLayer)
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        movieRatingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor).isActive = true
        movieRatingLabel.textAlignment = .center
        ratingView.addSubview(movieRatingLabel)
        animateStroke()
    }
    func animateStroke() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = percentage
        basicAnimation.duration = 0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
}
