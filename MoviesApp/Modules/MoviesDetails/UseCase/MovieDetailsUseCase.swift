//
//  MovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

protocol MovieDetailsUseCaseProtocol: AnyObject {
    func getMovie(id: Int) -> AnyPublisher<Movie, NetworkError>
}
class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    private let remoteRepository: MoviesDetailsRemoteRepositoryProtocol
    private var cancelable: Set<AnyCancellable> = []
    init(remoteRepository: MoviesDetailsRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    func getMovie(id: Int) -> AnyPublisher<Movie, NetworkError> {
        return Future<Movie, NetworkError> { [weak self] promise in
            guard let self else { return }
            let requestModel = MovieDetailsRequestModel(id: id)
            remoteRepository.getMovie(data: requestModel)
                .sink(receiveCompletion: { _ in}, receiveValue: { [weak self] movie in
                guard let self else { return }
                promise(.success(map(movie: movie)))
            }).store(in: &cancelable)
        }.eraseToAnyPublisher()

    }
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


