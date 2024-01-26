//
//  MovieDetailsRemoteRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
import Combine
/// MoviesDetailsRemoteRepositoryProtocol
protocol MoviesDetailsRemoteRepositoryProtocol: AnyObject {
    func getMovie(data: MovieDetailsRequestModel) -> AnyPublisher<MovieDetailsResponse, NetworkError>
}
