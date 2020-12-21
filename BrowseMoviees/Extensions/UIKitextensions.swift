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
    func showMoviesFromGenre(with genre: Genre) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MoviesListFromGenre") as! MoviesListFromGenreViewController
        controller.genre = genre
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func showLoginScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "LoginScreen")
        present(controller, animated: true, completion: nil)
    }
    func showMyListMovie() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "MyListOfMoviesViewController") as! MyListOfMoviesViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension UIBarButtonItem {
    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return menuBarItem
    }
}
