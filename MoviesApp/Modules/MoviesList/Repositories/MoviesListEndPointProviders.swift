//
//  MoviesListEndPointProviders.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

enum MoviesListEndPointProviders {
    case getMovies
    
}

extension MoviesListEndPointProviders: NetworkRequest {
    var baseURL: String {
        return "https://api.themoviedb.org/"
    }
    var endPoint: String {
        switch self {
        case .getMovies:
            return "3/discover/movie"
        }
    }
    var headers: [String: String]? {
        [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NGQyYjE1YTg4YWI2OTM2ZmU0YzFkNWViOTJhYjE0YiIsInN1YiI6IjY1YjA0NjVkZDEwMGI2MDEwYzgzM2ZhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Zx0lgCJrhQc6t1OspXQssUiCvjICzgC9qpZoMnB5DcY",
            "accept": "application/json"
        ]
    }
    var queryParams: [String: Any]? {
        return nil
    }
    var parameters: [String: Any]? {
        return nil
    }
    var method: NetworkHTTPMethod {
        switch self {
        case .getMovies:
            return .GET
        }
    }
}
