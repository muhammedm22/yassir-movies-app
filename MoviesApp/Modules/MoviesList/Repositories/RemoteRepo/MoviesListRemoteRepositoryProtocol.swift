//
//  MoviesListRemoteRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
import Combine
// Movies List Remote reposiitory protocol
protocol MoviesListRemoteRepositoryProtocol: AnyObject {
    func getMovies() -> AnyPublisher<MoviesListResponse, NetworkError>
}
