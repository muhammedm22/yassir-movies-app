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
        return AppConfig.baseURL
    }
    var endPoint: String {
        switch self {
        case .getMovies:
            return "3/discover/movie"
        }
    }
    var headers: [String: String]? {
        [
            "Authorization": AppConfig.apiToken,
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
