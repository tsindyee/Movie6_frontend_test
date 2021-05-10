//
//  MovieDetailsBasicInfoTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit
import Cosmos

class MovieDetailsBasicInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var starRatingView: CosmosView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    func configureCell(with movieDetailsItem: MovieDetailsItem!, dateString: String?) {
        starRatingView.settings.fillMode = .half
        if let rating = movieDetailsItem.rating {
            let ratingString = String(format: "%.1f", rating / 100)
            starRatingView.rating = rating / 100
            ratingLabel.text = ratingString
        } else {
            starRatingView.rating = 0
            ratingLabel.text = "- -"
        }
        nameLabel.text = movieDetailsItem.chiName
        favCountLabel.text = movieDetailsItem.favCount != nil ? "\(movieDetailsItem.favCount!)" : "0"
        commentsCountLabel.text = movieDetailsItem.commentCount != nil ? "\(movieDetailsItem.commentCount!)" : "0"
        dateLabel.text = dateString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
