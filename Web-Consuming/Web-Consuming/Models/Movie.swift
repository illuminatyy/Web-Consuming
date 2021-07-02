//
//  Movie.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import Foundation
import UIKit

struct Movie: Codable {
    var poster_path: String?
    var overview: String
    var genre_ids: [Int]
    var id: Int
    var title: String
    var vote_average: Double
}
