//
//  MoviesListRemoteRepository.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine
protocol MoviesListRemoteRepositoryProtocol: AnyObject {
    func getMovies() -> AnyPublisher<MoviesListResponse, NetworkError>
}
class MoviesListRemoteRepository: MoviesListRemoteRepositoryProtocol {
    let networkClient = NetworkClient(configuration: URLSession.shared.configuration, session: .shared)
    func getMovies() -> AnyPublisher<MoviesListResponse, NetworkError> {
        networkClient.request(
            request: MoviesListEndPointProviders.getMovies.makeRequest,
            mapToModel: MoviesListResponse.self)
    }
}
