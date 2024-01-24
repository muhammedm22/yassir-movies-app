//
//  MoviesDetailsRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//
import Foundation

protocol MoviesDetailsRemoteRepositoryProtocol: AnyObject {
    func getMovie(data: MovieDetailsRequestModel, completion: @escaping (Swift.Result<MovieDetailsResponse, NetworkError>) -> Void)
}
class MoviesDetailsRemoteRepository: MoviesDetailsRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    func getMovie(data: MovieDetailsRequestModel, completion: @escaping (Swift.Result<MovieDetailsResponse, NetworkError>) -> Void) {
        networkClient.request(
            request: MovieDetailsEndpointProviders.getMovie(data: data).makeRequest,
            mapToModel: MovieDetailsResponse.self, completion: completion)
    }
}
