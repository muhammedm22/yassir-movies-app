//
//  MovieDetailsUseCaseProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
import Combine
/// MovieDetailsUseCaseProtocol
protocol MovieDetailsUseCaseProtocol: AnyObject {
    func getMovie(id: Int) -> AnyPublisher<Movie, NetworkError>
}
