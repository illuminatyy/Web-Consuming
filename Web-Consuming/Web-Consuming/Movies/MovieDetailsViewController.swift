//
//  MovieDetailViewController.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewDetails: UITableView!
    
    var movieImage: UIImage?
    var movie: Movie?
    var genres: [Genre] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDetails.delegate = self
        tableViewDetails.dataSource = self
        
        guard let movie = movie else { return }

        Requester.request(apiRouter: .getDetails(movieId: movie.id)) { detailsData in
            guard let detailsData = detailsData else { return }
            guard let details = Parser<DetailsResponse>().parse(data: detailsData) else { return }
            
            self.genres = details.genres
            DispatchQueue.main.async {
                self.tableViewDetails.reloadData()
            }
        }
    }

//     MARK: - TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as? MovieDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.movieDetailsTitle.text = movie?.title
        var categories = ""
        for i in 0 ..< genres.count {
            if i == 0 {
                categories = genres[0].name
            } else {
                categories = "\(categories), \(genres[i].name)"
            }
        }
        cell.movieDetailsCategories.text = categories
        cell.movieDetailsRanking.text = movie?.vote_average.description
        cell.movieDetailsDescription.text = movie?.overview
        cell.movieDetailsImage.image = movieImage
        
        return cell
    }
}
