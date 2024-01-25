//
//  MovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

/// MovieDetailsUseCaseProtocol
protocol MovieDetailsUseCaseProtocol: AnyObject {
    func getMovie(id: Int, completion: @escaping (Movie) -> Void)
}
/// MovieDetailsUseCase Concerate class which implement bussiness logic
class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    private let remoteRepository: MoviesDetailsRemoteRepositoryProtocol
    init(remoteRepository: MoviesDetailsRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    /// Get movie by id
    /// - Parameter id: Movie id
    /// - Parameter : Completion with Movie
    func getMovie(id: Int, completion: @escaping (Movie) -> Void) {
        let requestModel = MovieDetailsRequestModel(id: id)
        remoteRepository.getMovie(data: requestModel,completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(movie):
                completion(map(movie: movie))
            case .failure:
                break
            }
        })
    }
    /// Mapping MovieResponse To Movie
    /// - Parameter movie: MovieDetailsResponse
    /// - Returns: Movie Model
    private func map(movie: MovieDetailsResponse) -> Movie {
        return  Movie(
            id: movie.id ?? 0,
            title: movie.title ?? "",
            desc: movie.overview ?? "",
            imageURL: URL(string:"\(AppConfig.imagesBaseURL)\(movie.posterPath ?? "")") ?? URL(fileURLWithPath: ""),
            releaseYear: movie.releaseDate ?? "",
            vote_average: 0.0
        )
    }
}


