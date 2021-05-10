//
//  ViewController.swift
//  MovieList
//
//  Created by Tang Sin Yee on 7/5/2021.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "MovieListItemTableViewCellId"

class MovieViewController: UIViewController {
    
    var isRepresentedAsTable = true
    
    lazy var movieListTableViewController: MovieListTableViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieListTableViewController") as! MovieListTableViewController
        self.add(viewController)
        return viewController
    }()

    lazy var movieGridCollectionController: MovieGridCollectionViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieGridCollectionViewController") as! MovieGridCollectionViewController
        self.add(viewController)
        return viewController
    }()

    func add(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)

        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func remove(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func updateView() {
        if isRepresentedAsTable {
            remove(movieGridCollectionController)
            add(movieListTableViewController)
            movieListTableViewController.movieItems = movieItems
            movieListTableViewController.tableView.reloadData()
        } else {
            remove(movieListTableViewController)
            add(movieGridCollectionController)
            movieGridCollectionController.movieItems = movieItems
            movieGridCollectionController.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    let dateFormatter = DateFormatter()
    
    var movieItems: [MovieListItem] = []
    
    
    @IBAction func changeRepresentationStyleButtonDidTap(_ sender: UIBarButtonItem) {
        isRepresentedAsTable = !isRepresentedAsTable
        sender.image = isRepresentedAsTable ? UIImage(systemName: "rectangle.grid.2x2") : UIImage(systemName: "list.bullet")
        updateView()
    }
    
    func userDidSelect(_ movieItem: MovieListItem) {
        let request = GetMovieDetailsRequest(with: movieItem.movieId)
        request.delegate = self
        request.sendRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let getMovieListRequest = GetMovieListRequest()
        getMovieListRequest.sendRequest()
        getMovieListRequest.delegate = self

        isRepresentedAsTable = true
        updateView()
    }
}

extension MovieViewController: GetMovieListRequestDelegate {
    func getMovieListRequest(_ request: GetMovieListRequest, didGet movieItems: [MovieListItem]!) {
        self.movieItems = movieItems
        DispatchQueue.main.async {
            self.updateView()
        }
    }
    
    func getMovieListRequest(_ request: GetMovieListRequest, didFailWith error: Error?) {
        
    }
}

extension MovieViewController: GetMovieDetailsRequestDelegate {
    func getMovieDetailsRequest(_ request: GetMovieDetailsRequest, didGet movieItems: MovieDetailsItem?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        DispatchQueue.main.async {
            if let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                viewController.movieDetailsItem = movieItems
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func getMovieDetailsRequest(_ request: GetMovieDetailsRequest, didFailWith error: Error?) {
        
    }
}

