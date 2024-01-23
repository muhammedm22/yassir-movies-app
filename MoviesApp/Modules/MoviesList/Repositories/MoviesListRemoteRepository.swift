//
//  MoviesListRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol MoviesListRemoteRepositoryProtocol: AnyObject {
    func getMovies(completion: @escaping (Swift.Result<MoviesListResponse, NetworkError>) -> Void)
}
class MoviesListRemoteRepository: MoviesListRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    func getMovies(completion: @escaping (Swift.Result<MoviesListResponse, NetworkError>) -> Void) {
        networkClient.request(
            request: MoviesListEndPointProviders.getMovies.makeRequest,
            mapToModel: MoviesListResponse.self, completion: completion)
    }
}


// MARK: - MoviesListResponse
struct MoviesListResponse: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let posterPath, title: String?


    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}
