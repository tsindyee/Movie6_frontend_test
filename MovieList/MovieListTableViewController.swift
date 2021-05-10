//
//  MovieListTableViewController.swift
//  MovieList
//
//  Created by Tang Sin Yee on 9/5/2021.
//

import UIKit

private let reuseIdentifier = "MovieListItemTableViewCellId"

class MovieListTableViewController: UITableViewController {
    
    private let dateFormatter = DateFormatter()
    
    var movieItems: [MovieListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.locale = Locale(identifier: "zh_Hans_HK")
        dateFormatter.dateStyle = .long
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        let movieListItem = movieItems[row]
        if let cell = cell as? MovieListItemTableViewCell {
            var dateString = "-"
            if let date = movieListItem.openDate {
                dateString = dateFormatter.string(from: date)
            }

            var thumbnailURL: URL?
            if let urlString = movieListItem.thumbnail {
                thumbnailURL = URL(string: urlString)
            }
            cell.configureCell(with: movieListItem, dateString: dateString, thumbnailURL: thumbnailURL)
            return cell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let movieListItem = movieItems[row]
        
        if let parent = parent as? MovieViewController {
            parent.userDidSelect(movieListItem)
        }
    }
}
