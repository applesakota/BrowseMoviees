//
//  UpcomingMoviesViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/12/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {


    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    
    var result: MovieList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingMoviesCollectionView.delegate = self
        upcomingMoviesCollectionView.dataSource = self
        upcomingMoviesCollectionView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        NetworkManager.shared.fetchMovies(from: MovieListEndpoint.upcoming) { (error) in

        } successHandler: { (model) in
            if let model = model as? MovieList {
                self.result = model
                DispatchQueue.main.async {
                    self.upcomingMoviesCollectionView.reloadData()
                }
            }
        }
        configureUI()
    }
    func configureUI() {
        setNavigation()
        upcomingMoviesCollectionView.backgroundColor = Constants.Design.Color.Gray
    }
    func setNavigation() {
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.Gray2
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.Design.Color.DarkGray]
        tabBarController?.tabBar.barTintColor = Constants.Design.Color.Gray2
        self.navigationItem.title = "Upcoming"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(movieProfile), imageName: "profile-user")
    }
    @objc func movieProfile() {
        self.showProfileScreen()
    }
    
}
extension UpcomingMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
