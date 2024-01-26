//
//  MoviesListRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

/// Movies List Remote reposiitory protcool
protocol MoviesListRemoteRepositoryProtocol: AnyObject {
    func getMovies() -> AnyPublisher<MoviesListResponse, NetworkError>
}
/// Movies List Remote concerate class
class MoviesListRemoteRepository: MoviesListRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    
    /// Get list of movies
    /// - Returns: Publisher<MoviesResponse, NetworkError>
    func getMovies() -> AnyPublisher<MoviesListResponse, NetworkError> {
        networkClient.request(
            request: MoviesListEndPointProviders.getMovies.makeRequest,
            mapToModel: MoviesListResponse.self)
    }
}
