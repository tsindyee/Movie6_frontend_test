//
//  MovieGridCollectionViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 9/5/2021.
//

import UIKit

class MovieGridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    func configure(with movieItem: MovieListItem) {
        if let rating = movieItem.rating {
            let ratingString = String(format: "%.1f", rating / 100)
            ratingLabel.text = ratingString
        } else {
            ratingLabel.text = "- -"
        }
        nameLabel.text = movieItem.chiName
        favCountLabel.text = movieItem.favCount != nil ? "\(movieItem.favCount!)" : "0"
        commentCountLabel.text = movieItem.commentCount != nil ? "\(movieItem.commentCount!)" : "0"
        if let thumbnailURL = movieItem.thumbnail {
            thumbnailView.kf.setImage(with: URL(string: thumbnailURL), placeholder: UIImage(systemName: "photo"))
        } else {
            thumbnailView.image = UIImage(systemName: "photo")
        }
    }
}
