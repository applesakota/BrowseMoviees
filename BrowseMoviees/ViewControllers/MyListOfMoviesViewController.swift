//
//  MyListOfMoviesViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/21/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
import UIKit

class MyListOfMoviesViewController: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var myListCollectionView: UICollectionView!
    
    var movies: [Movie]? = []
    
    func observerListenChangesOnPartiesData() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMoviesData), name: NSNotification.Name(UserManager.userMoviesChangedNotificationName), object: nil)
    }
    @objc func refreshMoviesData() {
        self.movies = UserManager.shared.user?.movies ?? []
        self.myListCollectionView.reloadData()
        configureUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myListCollectionView.delegate = self
        myListCollectionView.dataSource = self
        refreshMoviesData()
        observerListenChangesOnPartiesData()
        myListCollectionView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        if movies?.count == 0 {
            configureEmptyScreen()
        } else {
            configureUI()
        }
    }
    func configureEmptyScreen() {
        emptyView.backgroundColor = Constants.Design.Color.BlackColor
    }
    func configureUI() {
        emptyView.isHidden = true
        myListCollectionView.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        myListCollectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    func setNavigation() {
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.BlackColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.Design.Color.WhiteColor]
        self.navigationItem.title = "My List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(movieProfile), imageName: "profile-user-4")
    }
    @objc func movieProfile() {
        //Add new view Controllers
        self.showProfileScreen()
    }
    
}
extension MyListOfMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            fatalError("Cannot create cell")
        }
        item.configureUI(movie: movies![indexPath.row])
        return item
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 30) / 2, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = movies?[indexPath.row]
        self.showMovieDetailScreen(with: data!)
    }
}

