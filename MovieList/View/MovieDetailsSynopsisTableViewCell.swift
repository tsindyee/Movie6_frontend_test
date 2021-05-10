//
//  MovieDetailsSynopsisTableViewCell.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit
import ReadMoreTextView

class MovieDetailsSynopsisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: ReadMoreTextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.maximumNumberOfLines = 5
        let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.systemYellow,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
        ]
        textView.attributedReadMoreText = NSAttributedString(string: "...查看更多", attributes: readMoreTextAttributes)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textView.onSizeChange = { _ in }
        textView.shouldTrim = true
    }

}
