//
//  MovieDetailsBasicInfoTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit

class MovieDetailsBasicInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    @IBOutlet var ratingStarCollection: [UIImageView]!
    
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
    
    func configureCell(with movieDetailsItem: MovieDetailsItem!, dateString: String?) {
        if let rating = movieDetailsItem.rating {
            let ratingString = String(format: "%.1f", rating / 100)
            setRating(rating)
            ratingLabel.text = ratingString
        } else {
            setRating(0)
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
