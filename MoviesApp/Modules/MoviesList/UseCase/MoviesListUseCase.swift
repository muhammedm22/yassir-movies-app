//
//  MoviesListUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

/// MoviesList Usecase Protcool
protocol MoviesListUseCaseProtocol: AnyObject {
    func getMovies() -> AnyPublisher<[Movie], NetworkError>
}

/// MoviesList Usecase Protocol whcih contains Movies List bussiness logic
class MoviesListUseCase: MoviesListUseCaseProtocol {
    private let remoteRepository: MoviesListRemoteRepositoryProtocol
    private var cancelable: Set<AnyCancellable> = []
    
    /// Init
    /// - Parameter remoteRepository: MoviesListRemoteRepositoryProtocol
    init(remoteRepository: MoviesListRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    
    /// Get all Movies and map it to array Publisher
    /// - Returns: AnyPublisher<[Movie], NetworkError>
    func getMovies() -> AnyPublisher<[Movie], NetworkError> {
        return Future<[Movie], NetworkError> { [weak self] promise in
            guard let self else { return }
            remoteRepository.getMovies().sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movies in
                guard let self else { return }
                promise(.success(map(movies: movies.results ?? [])))
            }).store(in: &cancelable)
        }.eraseToAnyPublisher()
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
