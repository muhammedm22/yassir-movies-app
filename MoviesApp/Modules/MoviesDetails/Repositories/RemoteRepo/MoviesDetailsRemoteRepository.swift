//
//  MoviesDetailsRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//
import Foundation

/// MoviesDetailsRemoteRepository concerate class
class MoviesDetailsRemoteRepository: MoviesDetailsRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    /// Ge tMovie by selected data (id)
    /// - Parameter data: MovieDetailsRequestModel
    /// - Parameter:  Completion with <MovieDetailsResponse, NetworkError>
    func getMovie(data: MovieDetailsRequestModel, completion: @escaping (Swift.Result<MovieDetailsResponse, NetworkError>) -> Void) {
        networkClient.request(
            request: MovieDetailsEndpointProviders.getMovie(data: data).makeRequest,
            mapToModel: MovieDetailsResponse.self, completion: completion)
    }
}
