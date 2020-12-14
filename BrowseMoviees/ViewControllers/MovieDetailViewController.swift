//
//  MovieDetailViewController.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var movieDetailTableView: UITableView!
    
    var movieList: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
}
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Cast:" : nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 0, section: 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as? MovieDetailCell else {
                fatalError()
            }
            cell.configureUI(movie: movieList!)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastMovieCell", for: indexPath) as? CastMovieCell else  { fatalError() }
        cell.configureUI()
        return cell
    }
}
