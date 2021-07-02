//
//  DetailsResponse.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 02/07/21.
//

import Foundation

struct DetailsResponse: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    var id: Int
    var name: String
}
