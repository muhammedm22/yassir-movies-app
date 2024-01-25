//
//  MoviesDetailsRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//
import Foundation
import Combine

protocol MoviesDetailsRemoteRepositoryProtocol: AnyObject {
    func getMovie(data: MovieDetailsRequestModel) -> AnyPublisher<MovieDetailsResponse, NetworkError>
}
class MoviesDetailsRemoteRepository: MoviesDetailsRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    func getMovie(data: MovieDetailsRequestModel) -> AnyPublisher<MovieDetailsResponse, NetworkError> {
        networkClient.request(
            request: MovieDetailsEndpointProviders.getMovie(data: data).makeRequest,
            mapToModel: MovieDetailsResponse.self)
    }
}
