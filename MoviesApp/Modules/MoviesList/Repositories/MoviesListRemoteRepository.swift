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
