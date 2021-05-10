//
//  GetMovieDetailsRequest.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import Foundation

protocol GetMovieDetailsRequestDelegate: NSObject {
    func getMovieDetailsRequest(_ request: GetMovieDetailsRequest, didGet movieItems: MovieDetailsItem?)
    func getMovieDetailsRequest(_ request: GetMovieDetailsRequest, didFailWith error: Error?)
}

class GetMovieDetailsRequest: NSObject {
    
    let url: URL?
    weak var delegate: GetMovieDetailsRequestDelegate?
    
    init(with movieId: Int) {
        self.url = URL(string: "https://api.hkmovie6.com/hkm/movies/\(movieId)")
        super.init()
    }
    
    func convertMovieListItem(with movieList: [String:Any]?) -> MovieDetailsItem? {
        guard let movieList = movieList else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_HK")
        dateFormatter.dateFormat = "E dd MMM yyyy hh:mm:ss"
        
        guard let id = movieList["id"] as? Int else {
            return nil
        }
        let name = movieList["name"] as? String
        let chiName = movieList["chiName"] as? String
        let chiSynopsis = movieList["chiSynopsis"] as? String
        let rating = movieList["rating"] as? Double
        let favCount = movieList["favCount"] as? Int
        let commentCount = movieList["commentCount"] as? Int
        let chiInfoDict = movieList["chiInfoDict"] as? [String:String]
        let screenShotUrlStrings = movieList["screenShots"] as? [String]
        
        var openDate: Date?
        if let dateString = movieList["openDate"] as? String, let date = dateFormatter.date(from: dateString) {
            openDate = date
        }
        
        let movieItem = MovieDetailsItem(with: id, name: name, chiName: chiName, chiSynopsis: chiSynopsis, openDate: openDate, rating: rating, favCount: favCount, commentCount: commentCount, chiInfoDict: chiInfoDict, screenShotUrlStrings: screenShotUrlStrings)
        print(movieItem)
        return movieItem
    }
    
    func sendRequest() {
        guard let requestUrl = url else {
            return
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                    let movieDetailsItem = self.convertMovieListItem(with: convertedJsonIntoDict)
                    self.delegate?.getMovieDetailsRequest(self, didGet: movieDetailsItem)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
