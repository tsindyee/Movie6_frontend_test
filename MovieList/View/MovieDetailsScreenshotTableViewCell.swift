//
//  MovieDetailsScreenshotTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit
import ImageSlideshow

class MovieDetailsScreenshotTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
