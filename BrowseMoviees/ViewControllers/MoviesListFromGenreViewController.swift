//
//  MoviesListFromGenreViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/17/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
import UIKit

class MoviesListFromGenreViewController: UIViewController {
    
    var genre: Genre?
    var result: MovieList?
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        NetworkManager.shared.getMoviesFromGenre(from: MovieListEndpoint.discover, genreID: genre?.id ?? 0) { (error) in
            self.presentError(message: error.localizedDescription)
        } successHandler: { (model) in
            if let model = model as? MovieList {
                self.result = model
                DispatchQueue.main.async {
                    self.movieListCollectionView.reloadData()
                }
            }
        }
        configureUI()
    }
    func configureUI() {
        setNavigation()
        movieListCollectionView.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        movieListCollectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    func setNavigation() {
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.BlackColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.Design.Color.WhiteColor]
        self.navigationItem.title = genre?.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(movieProfile), imageName: "profile-user-4")
    }
    @objc func movieProfile() {
        //Add new view Controllers
        self.showProfileScreen()
    }
}
extension MoviesListFromGenreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.results.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            fatalError("Cannot create cell")
        }
        item.configureUI(movie: result!.results[indexPath.row])
        return item
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 30) / 2, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = result?.results[indexPath.row]
        self.showMovieDetailScreen(with: data!)
    }
}

