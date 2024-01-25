//
//  MoviesListUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

protocol MoviesListUseCaseProtocol: AnyObject {
    func getMovies() -> AnyPublisher<[Movie], NetworkError>
}
class MoviesListUseCase: MoviesListUseCaseProtocol {
    private let remoteRepository: MoviesListRemoteRepositoryProtocol
    private var cancelable: Set<AnyCancellable> = []
    init(remoteRepository: MoviesListRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    func getMovies() -> AnyPublisher<[Movie], NetworkError> {
        return Future<[Movie], NetworkError> { [weak self] promise in
            guard let self else { return }
            remoteRepository.getMovies().sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movies in
                guard let self else { return }
                promise(.success(map(movies: movies.results ?? [])))
            }).store(in: &cancelable)
        }.eraseToAnyPublisher()
    }
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
