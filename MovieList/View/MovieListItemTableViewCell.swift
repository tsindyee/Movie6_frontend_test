//
//  MovieListItemTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit
import Cosmos
import Kingfisher

class MovieListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!

    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with movieListItem: MovieListItem!, dateString: String?, thumbnailURL: URL?) {
        starView.settings.fillMode = .half
        if let rating = movieListItem.rating {
            let ratingString = String(format: "%.1f", rating / 100)
            starView.rating = rating / 100
            ratingLabel.text = ratingString
        } else {
            starView.rating = 0
            ratingLabel.text = "- -"
        }
        nameLabel.text = movieListItem.chiName
        favCountLabel.text = movieListItem.favCount != nil ? "\(movieListItem.favCount!)" : "0"
        commentCountLabel.text = movieListItem.commentCount != nil ? "\(movieListItem.commentCount!)" : "0"
        thumbnailView.kf.setImage(with: thumbnailURL, placeholder: UIImage(systemName: "photo"))
        dateLabel.text = dateString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
