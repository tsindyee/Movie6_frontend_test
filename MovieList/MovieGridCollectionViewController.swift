//
//  MovieGridCollectionViewController.swift
//  MovieList
//
//  Created by Tang Sin Yee on 9/5/2021.
//

import UIKit

private let reuseIdentifier = "MovieGridViewCellId"

class MovieGridCollectionViewController: UICollectionViewController {
    
    var movieItems: [MovieListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieGridCollectionViewCell
        let movieItem = movieItems[indexPath.row]
        cell.configure(with: movieItem)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let movieItem = movieItems[row]
        
        if let parent = parent as? MovieViewController {
            parent.userDidSelect(movieItem)
        }
    }
}
