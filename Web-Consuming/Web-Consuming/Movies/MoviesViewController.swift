//
//  MoviesViewController.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    var popMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - Search Bar on Navigation Bar
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        self.navigationItem.titleView = self.searchController.searchBar
        self.definesPresentationContext = true
        // fix searchBar position and create a placeholder
        
        loadMovies()
        
    }
    
    func loadMovies() {
        Requester.request(apiRouter: MovieDBAPIRouter.getPopular(page: 1)) { data in
            guard let data = data else { return }
            guard let popularMoviesResponse = Parser<PopularMoviesResponse>().parse(data: data) else { return }
            
            self.popMovies = popularMoviesResponse.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popMovies.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popular Movies"
        } else {
            return "Now Playing"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.movieTitle.text = popMovies[indexPath.row].title
            cell.moviewShortDescription.text = popMovies[indexPath.row].overview
            cell.movieRanking.text = popMovies[indexPath.row].vote_average.description
//            if let imageURL = URL(string: popMovies[indexPath.row].poster_path ?? "") {
//                if let imageData = try? Data(contentsOf: imageURL) {
//                    cell.movieImage.image = UIImage(data: imageData)
//                }
//            }
            Requester.request(apiRouter: MovieDBAPIRouter.getImage(poster_path: popMovies[indexPath.row].poster_path ?? "")) { imageData in
                if let imageData = imageData {
                    DispatchQueue.main.async {
                        cell.movieImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetails", sender: indexPath)
    }
    
    
    // MARK: - Segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vC = segue.destination as? MovieDetailsViewController {
//
//        }
//    }
}
