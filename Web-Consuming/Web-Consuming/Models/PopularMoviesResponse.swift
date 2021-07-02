//
//  PopularMoviesResponse.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import Foundation

struct PopularMoviesResponse: Codable {
    var page: Int
    var results: [Movie]
    var total_results: Int
    var total_pages: Int
}
