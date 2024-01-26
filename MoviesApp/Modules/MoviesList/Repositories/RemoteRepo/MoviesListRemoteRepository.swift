//
//  MoviesListRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
/// Movies List Remote concerate class
class MoviesListRemoteRepository: MoviesListRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    /// Get list of movies
    /// - Parameters : Completion with Result <MoviesResponse, NetworkError>
    func getMovies(completion: @escaping (Swift.Result<MoviesListResponse, NetworkError>) -> Void) {
        networkClient.request(
            request: MoviesListEndPointProviders.getMovies.makeRequest,
            mapToModel: MoviesListResponse.self, completion: completion)
    }
}
