//
//  GenresViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController {

    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    var genres: [Genre] = []{
        didSet {
            DispatchQueue.main.async {
                self.genresCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        genresCollectionView.register(UINib.init(nibName: "GenreCell", bundle: nil), forCellWithReuseIdentifier: "GenreCell")
        NetworkManager.shared.getCategories(from: MovieListEndpoint.genre) { (error) in
            
        } successHandler: { (model) in
            if let model = model as? [Genre] {
                self.genres = model
            }
        }
        configureUI()
    }
    //ui
    func configureUI() {
        setNavigation()
        genresCollectionView.backgroundColor = Constants.Design.Color.BlackBacgroundColor
        genresCollectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    func setNavigation() {
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.BlackColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Constants.Design.Color.WhiteColor]
        self.navigationItem.title = "Genres"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(movieProfile), imageName: "profile-user-4")
    }
    @objc func movieProfile() {
        self.showProfileScreen()
    }
}
extension GenresViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as? GenreCell else {
            fatalError("Cannot load cell")
        }
        item.configureUI(genre: genres[indexPath.row])
        return item
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 30) / 2, height: 130)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGenre = genres[indexPath.row]
        self.showMoviesFromGenre(with: selectedGenre)
    }
}
