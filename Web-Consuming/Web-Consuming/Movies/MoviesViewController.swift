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
    var nowPlayingMovies: [Movie] = []
    var moviesImages: [Int: UIImage] = [:]
    
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
            guard let popularMoviesResponse = Parser<MoviesResponse>().parse(data: data) else { return }
            
            let downloadedMoviesNumber = popularMoviesResponse.results.count
            
            popularMoviesResponse.results.forEach { movie in
                if let posterPath = movie.poster_path {
                    Requester.request(apiRouter: .getImage(poster_path: posterPath)) { imageData in
                        self.popMovies.append(movie)
                        if let imageData = imageData {
                            self.moviesImages[movie.id] = UIImage(data: imageData)
                        }
                        if self.popMovies.count == downloadedMoviesNumber {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                else {
                    self.popMovies.append(movie)
                    if self.popMovies.count == downloadedMoviesNumber {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        Requester.request(apiRouter: .getNowPlaying(page: 1)) { data in
            guard let data = data else { return }
            guard let nowPlayingResponse = Parser<MoviesResponse>().parse(data: data) else { return }
            
            let downloadedMoviesNumber = nowPlayingResponse.results.count
            
            nowPlayingResponse.results.forEach { movie in
                if let posterPath = movie.poster_path {
                    Requester.request(apiRouter: .getImage(poster_path: posterPath)) { imageData in
                        self.nowPlayingMovies.append(movie)
                        if let imageData = imageData {
                            self.moviesImages[movie.id] = UIImage(data: imageData)
                        }
                        if self.nowPlayingMovies.count == downloadedMoviesNumber {
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                else {
                    self.nowPlayingMovies.append(movie)
                    if self.nowPlayingMovies.count == downloadedMoviesNumber {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return popMovies.count
        } else {
            return nowPlayingMovies.count
        }
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
        
        let movie = indexPath.section == 0 ? popMovies[indexPath.row] : nowPlayingMovies[indexPath.row]
        
        cell.movieTitle.text = movie.title
        cell.moviewShortDescription.text = movie.overview
        cell.movieRanking.text = movie.vote_average.description
        cell.movieImage.image = moviesImages[movie.id]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetails", sender: indexPath)
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vC = segue.destination as? MovieDetailsViewController {
            if let indexPath = sender as? IndexPath {
                let movie = indexPath.section == 0 ? popMovies[indexPath.row] : nowPlayingMovies[indexPath.row]
                vC.movie = movie
                vC.movieImage = moviesImages[movie.id]
            }
        }
    }
}
