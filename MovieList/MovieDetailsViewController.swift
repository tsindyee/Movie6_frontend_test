//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Tang Sin Yee on 8/5/2021.
//

import UIKit
import ImageSlideshow

enum MovieDetailsTableViewCell: String, CaseIterable {
    case screenshot = "MovieDetailsScreenshotTableViewCellId"
    case basicInfo = "MovieDetailsBasicInfoTableViewCellId"
    case synopsis = "MovieDetailsSynopsisTableViewCellId"
    case otherInfo = "MovieDetailsOtherInfoTableViewCellId"
}

class MovieDetailsViewController: UIViewController {
    
    var movieDetailsItem: MovieDetailsItem?

    @IBOutlet weak var tableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var shouldTrim = true
    
    override func viewDidLayoutSubviews() {
        // bug fixes on synopsisCell.textView not showing "Read more" for long text cases
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        dateFormatter.locale = Locale(identifier: "zh_Hans_HK")
        dateFormatter.dateStyle = .long
        // Do any additional setup after loading the view.
    }

}

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let tableSection = MovieDetailsTableViewCell.allCases[section]
        if tableSection == .synopsis, let cell = tableView.cellForRow(at: indexPath) as? MovieDetailsSynopsisTableViewCell {
            cell.textView.shouldTrim = !shouldTrim
        }
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let tableSection = MovieDetailsTableViewCell.allCases[section]
        if tableSection == .synopsis, let cell = cell as? MovieDetailsSynopsisTableViewCell {
            cell.textView.onSizeChange = { [unowned tableView, unowned self] r in
                shouldTrim = r.shouldTrim
                tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return movieDetailsItem?.chiInfo?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let tableSection = MovieDetailsTableViewCell.allCases[section]
        let identifier = tableSection.rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        switch tableSection {
        case .screenshot:
            
            guard let screenShotCell = cell as? MovieDetailsScreenshotTableViewCell else {
                return cell
            }
            if let screenshotURL = movieDetailsItem?.screenShotUrlStrings {
                let sdWebImageSource = screenshotURL.map { SDWebImageSource(urlString:$0)! }
                screenShotCell.imageSlideshow.setImageInputs(sdWebImageSource)
            }
            return screenShotCell
            
        case .basicInfo:
            guard let basicInfoCell = cell as? MovieDetailsBasicInfoTableViewCell else {
                return cell
            }
            var dateString = "-"
            if let date = movieDetailsItem?.openDate {
                dateString = dateFormatter.string(from: date)
            }
            basicInfoCell.configureCell(with: movieDetailsItem, dateString: dateString)
            
            return basicInfoCell
            
        case .otherInfo:
            guard let infoCell = cell as? MovieDetailsInfoTableViewCell else {
                return cell
            }
            if let info = movieDetailsItem?.chiInfo?[indexPath.row] {
                infoCell.keyLabel.text = info.key
                infoCell.detailsLabel.text = info.info
            } else {
                infoCell.keyLabel.text = ""
                infoCell.detailsLabel.text = ""
            }
            return infoCell
            
        case .synopsis:
            guard let synopsisCell = cell as? MovieDetailsSynopsisTableViewCell else {
                return cell
            }
            synopsisCell.textView.text = movieDetailsItem?.chiSynopsis ?? ""
            synopsisCell.textView.textColor = .white
            synopsisCell.textView.shouldTrim = shouldTrim
            synopsisCell.textView.setNeedsUpdateTrim()
            synopsisCell.textView.layoutIfNeeded()
            break
        }
        return cell
    }
    
    
}
