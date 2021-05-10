//
//  MovieDetailsItem.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import Foundation

class MovieDetailsItem: NSObject {
    let movieId: Int
    let chiName: String?
    let chiSynopsis: String?
    let rating: Double?
    let openDate: Date?
    let commentCount: Int?
    let favCount: Int?
    let chiInfo: [(key: String, info: String)]?
    let screenShotUrlStrings: [String]?
    
    init(with id: Int!, name: String?, chiName: String?, chiSynopsis: String?, openDate: Date?, rating: Double?, favCount: Int?, commentCount: Int?, chiInfoDict: [String:String]?, screenShotUrlStrings: [String]?) {
        self.movieId = id
        self.chiName = chiName
        self.chiSynopsis = chiSynopsis
        self.openDate = openDate
        self.rating = rating
        self.favCount = favCount
        self.commentCount = commentCount
        self.screenShotUrlStrings = screenShotUrlStrings
        
        var chiInfo: [(key: String, info: String)] = []
        if let chiInfoDict = chiInfoDict {
            chiInfoDict.enumerated().forEach { index, element in
                chiInfo.append((key: element.key, info: element.value))
            }
        }
        self.chiInfo = chiInfo
        super.init()
    }
    
}
