//
//  ViewController.swift
//  BrowseMoviees
//
//  Created by Petar Sakotic on 12/9/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class SpashViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    static let shared = SpashViewController()
    var user: User?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        user = UserManager.shared.getLastSignUser()
        if user?.isLogin ?? false {
            self.showMainScreen()
        } else {
            self.showLoginScreen()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCategories(from: MovieListEndpoint.genre) { (error) in
        
        } successHandler: { (model) in
            if let model = model as? [Genre] {
                AppGlobals.shared.genres = model
            }
        }
        configureUI()
    }
    //MARK: -UI
    func configureUI() {
        infoLabel.text = "It's movie time!"
        infoLabel.textColor = Constants.Design.Color.White
        getStartedButton.layer.cornerRadius = 20
        getStartedButton.layer.backgroundColor = Constants.Design.Color.GrayCG
        getStartedButton.layer.borderWidth = 2
        getStartedButton.layer.borderColor = Constants.Design.Color.DarkGrayCG
        view.backgroundColor = Constants.Design.Color.Black
    }
}


