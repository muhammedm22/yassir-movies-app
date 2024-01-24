//
//  MoviesListUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
protocol MoviesListUseCaseProtocol: AnyObject {
    func getMovies(completion: @escaping ([Movie]) -> Void)
}
class MoviesListUseCase: MoviesListUseCaseProtocol {
    private let remoteRepository: MoviesListRemoteRepositoryProtocol
    init(remoteRepository: MoviesListRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
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
    
    private func map(movies: [MoviesListResult]) -> [Movie] {
        return movies.map{ Movie(
            id: $0.id ?? 0,
            title: $0.title ?? "",
            desc: $0.overview ?? "",
            imageURL: URL(string:"\(AppConfig.imagesBaseURL)\($0.posterPath ?? "")") ?? URL(fileURLWithPath: "")
        )}
    }
}
