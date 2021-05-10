//
//  MovieDetailsInfoTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit

class MovieDetailsInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
