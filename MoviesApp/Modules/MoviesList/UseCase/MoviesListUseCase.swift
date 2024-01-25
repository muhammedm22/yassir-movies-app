//
//  MoviesListUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
/// MoviesList Usecase Protcool
protocol MoviesListUseCaseProtocol: AnyObject {
    func getMovies(completion: @escaping ([Movie]) -> Void)
}

/// MoviesList Usecase Protocol whcih contains Movies List bussiness logic
class MoviesListUseCase: MoviesListUseCaseProtocol {
    private let remoteRepository: MoviesListRemoteRepositoryProtocol
    /// Init
    /// - Parameter remoteRepository: MoviesListRemoteRepositoryProtocol
    init(remoteRepository: MoviesListRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    /// Get all Movies and map it to array Publisher
    /// - Parameter completion with List of Movie
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        remoteRepository.getMovies(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(movies):
                completion(map(movies: movies.results ?? []))
            case .failure:
                completion([])
            }
        })
    }
    /// Mapping moviesResponseResults to [Movie]
    /// - Parameter movies: [MoviesListResult]]
    /// - Returns: [Movie]]
    private func map(movies: [MoviesListResult]) -> [Movie] {
        return movies.map{ Movie(
            id: $0.id ?? 0,
            title: $0.title ?? "",
            desc: $0.overview ?? "",
            imageURL: URL(string:"\(AppConfig.imagesBaseURL)\($0.posterPath ?? "")") ?? URL(fileURLWithPath: ""),
            releaseYear: $0.release_date ?? "",
            vote_average: $0.vote_average ?? 0.0
        )}
    }
}
