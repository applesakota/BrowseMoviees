//
//  TrendingMoviesViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class TrendingMoviesViewController: UIViewController {

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    var result: MovieList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        NetworkManager.shared.fetchMovies(from: MovieListEndpoint.trending) { (error) in
            
        } successHandler: { (model) in
            if let model = model as? MovieList {
                self.result = model
                DispatchQueue.main.async {
                    self.trendingCollectionView.reloadData()
                    
                }
            }
        }
        configureUI()
        navigation()
    }
    //UI
    func navigation() {
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.Gray2
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.Design.Color.DarkGray]
        tabBarController?.tabBar.barTintColor = Constants.Design.Color.Gray2
    }
    func configureUI() {
        trendingCollectionView.backgroundColor = Constants.Design.Color.Gray
    }
    

}
//Extensions
extension TrendingMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
}
