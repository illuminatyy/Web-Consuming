//
//  APIRouter.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 01/07/21.
//

import Foundation

protocol APIRouterProtocol {
    var requestType: RequestType { get }
    var baseURL: String { get }
    var apiKey: String { get }
    var path: String { get }
}

enum MovieDBAPIRouter: APIRouterProtocol {
    case getPopular(page: Int)
    case getImage(poster_path: String)
    
    var requestType: RequestType {
        switch self {
        case .getPopular:
            return .get
        case .getImage:
            return .get
        }
    }
    
    var baseURL: String {
        switch self {
        case .getPopular:
            return "https://api.themoviedb.org/3"
        case .getImage:
            return "https://image.tmdb.org/t/p/original"
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
        }
    }
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
