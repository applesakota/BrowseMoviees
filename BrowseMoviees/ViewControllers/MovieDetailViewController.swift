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
    var creditsList: CreditsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self

        // Do any additional setup after loading the view.
        NetworkManager.shared.getCredits(from: movieList?.id ?? 0, endpoint: MovieListEndpoint.credits) { (error) in

        } successHandler: { (model) in
            if let model = model as? CreditsList {
                self.creditsList = model
                DispatchQueue.main.async {
                    self.movieDetailTableView.reloadData()
                }
            }
                   }

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
        return section == 0 ? 1 : creditsList?.cast?.count ?? 0
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
        cell.configureUI(credits: (creditsList!.cast?[indexPath.row])!)
        return cell
    }
    
}
