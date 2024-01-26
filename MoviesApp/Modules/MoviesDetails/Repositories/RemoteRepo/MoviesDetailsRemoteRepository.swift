//
//  MoviesDetailsRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//
import Foundation
import Combine

/// MoviesDetailsRemoteRepository concerate class
class MoviesDetailsRemoteRepository: MoviesDetailsRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    
    /// Ge tMovie by selected data (id)
    /// - Parameter data: MovieDetailsRequestModel
    /// - Returns: Publisher with <MovieDetailsResponse, NetworkError>
    func getMovie(data: MovieDetailsRequestModel) -> AnyPublisher<MovieDetailsResponse, NetworkError> {
        networkClient.request(
            request: MovieDetailsEndpointProviders.getMovie(data: data).makeRequest,
            mapToModel: MovieDetailsResponse.self)
    }
}
