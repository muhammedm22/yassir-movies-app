//
//  MovieDetailsEndpointProviders.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

enum MovieDetailsEndpointProviders {
    case getMovie(data: MovieDetailsRequestModel)
    
}

extension MovieDetailsEndpointProviders: NetworkRequest {
    var baseURL: String {
        return AppConfig.baseURL
    }
    var endPoint: String {
        switch self {
        case let .getMovie(data):
            return "3/movie/\(data.id)"
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
        case .getMovie:
            return .GET
        }
    }
}
