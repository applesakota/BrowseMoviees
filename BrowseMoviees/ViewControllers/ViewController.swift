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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: -UI
    func configureUI() {
        infoLabel.text = "It's movie time!"
        getStartedButton.layer.cornerRadius = 20
    }
    

}


