//
//  UIKitextensions.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/10/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func showMainScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MainScreen")
        present(controller, animated: true, completion: nil)
    }
    func showProfileScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "ProfileScreen")
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func showMovieDetailScreen(with data: Movie) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        controller.movieList = data
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
