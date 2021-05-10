//
//  MovieListItem.swift
//  MovieList
//
//  Created by Tang Sin Yee on 7/5/2021.
//

import Foundation

class MovieListItem: NSObject {
    let movieId: Int!
    let name: String?
    let chiName: String?
    let thumbnail: String?
    let openDate: Date?
    let rating: Double?
    let favCount: Int?
    let commentCount: Int?
    
    init(with id: Int!, name: String?, chiName: String?, thumbnail: String?, openDate: Date?, rating: Double?, favCount: Int?, commentCount: Int?) {
        self.movieId = id
        self.name = name
        self.chiName = chiName
        self.thumbnail = thumbnail
        self.openDate = openDate
        self.rating = rating
        self.favCount = favCount
        self.commentCount = commentCount
        
        super.init()
    }
}
