//
//  APIRouter.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import Foundation

enum MovieDBAPIRouter {
    case getPopular(page: Int)
    case getNowPlaying(page: Int)
    case getImage(poster_path: String)
    case getDetails(movieId: Int)
    
    var baseURL: String {
        switch self {
        case .getPopular:
            return "https://api.themoviedb.org/3"
        case .getImage:
            return "https://image.tmdb.org/t/p/original"
        case .getNowPlaying:
            return "https://api.themoviedb.org/3"
        case .getDetails:
            return "https://api.themoviedb.org/3"
        }
    }
    
    var apiKey: String {
        "67e15e91b36f5518c9415ec5db9ecddb"
    }
    
    var path: String {
        switch self {
        case .getPopular(page: let page):
            return "\(baseURL)/movie/popular?api_key=\(apiKey)&page=\(page)"
        case .getImage(poster_path: let poster_path):
            return "\(baseURL)\(poster_path)"
        case .getNowPlaying(page: let page):
            return "\(baseURL)/movie/now_playing?api_key=\(apiKey)&page=\(page)"
        case .getDetails(movieId: let movieId):
            return "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)"
        }
    }
}
