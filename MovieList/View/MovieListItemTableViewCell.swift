//
//  MovieListItemTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit
import Kingfisher

class MovieListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var ratingStarCollection: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setRating(_ rating: Double) {
        let fullStarCount = Int(rating) / 100
        let withHalfStar = Int(rating) % 100 != 0
        ratingStarCollection.forEach { $0.image = UIImage(systemName: "star") }
        for i in 0..<fullStarCount {
            ratingStarCollection[i].image = UIImage(systemName: "star.fill")
        }
        if withHalfStar, fullStarCount < 5 {
            ratingStarCollection[fullStarCount].image = UIImage(systemName: "star.fill.left")
        }
    }
    
    func configureCell(with movieListItem: MovieListItem!, dateString: String?, thumbnailURL: URL?) {
        if let rating = movieListItem.rating {
            let ratingString = String(format: "%.1f", rating / 100)
            setRating(rating)
            ratingLabel.text = ratingString
        } else {
            setRating(0)
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
