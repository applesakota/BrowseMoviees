//
//  GenreCell.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/13/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {

    @IBOutlet weak var genreImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func configureUI(genre: Genre) {
        genreLabel.text = genre.name
        self.backgroundColor = Constants.Design.Color.Gray
    }

}
