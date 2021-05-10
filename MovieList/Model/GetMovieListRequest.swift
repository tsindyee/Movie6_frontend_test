//
//  GetMovieListRequest.swift
//  MovieList
//
//  Created by Tang Sin Yee on 7/5/2021.
//

import Foundation

protocol GetMovieListRequestDelegate: NSObject {
    func getMovieListRequest(_ request: GetMovieListRequest, didGet movieItems: [MovieListItem]!)
    func getMovieListRequest(_ request: GetMovieListRequest, didFailWith error: Error?)
}

class GetMovieListRequest: NSObject {
    
    let url = URL(string: "https://api.hkmovie6.com/hkm/movies?type=showing")
    weak var delegate: GetMovieListRequestDelegate?
    
    func convertMovieListItem(with movieList: [[String:Any]]?) -> [MovieListItem] {
        guard let movieList = movieList else {
            return []
        }
        var allMovieListItems: [MovieListItem] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_HK")
        dateFormatter.dateFormat = "E dd MMM yyyy hh:mm:ss"
        
        for movieDict in movieList {
            guard let id = movieDict["id"] as? Int else {
                continue
            }
            let name = movieDict["name"] as? String
            let chiName = movieDict["chiName"] as? String
            let thumbnail = movieDict["thumbnail"] as? String
            let rating = movieDict["rating"] as? Double
            let favCount = movieDict["favCount"] as? Int
            let commentCount = movieDict["commentCount"] as? Int
            
            
            var openDate: Date?
            if let dateString = movieDict["openDate"] as? String, let date = dateFormatter.date(from: dateString) {
                openDate = date
            }
            
            let movieItem = MovieListItem(with: id, name: name, chiName: chiName, thumbnail: thumbnail, openDate: openDate, rating: rating, favCount: favCount, commentCount: commentCount)
            print(movieItem)
            allMovieListItems.append(movieItem)
        }
        return allMovieListItems
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
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]] {

                    let movieListItems = self.convertMovieListItem(with: convertedJsonIntoDict)
                    self.delegate?.getMovieListRequest(self, didGet: movieListItems)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
