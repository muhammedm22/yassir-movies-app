//
//  MoviesListUseCase.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
protocol MoviesListUseCaseProtocol: AnyObject {
    func getMovies()
}
class MoviesListUseCase: MoviesListUseCaseProtocol {
    private let remoteRepository: MoviesListRemoteRepositoryProtocol
    init(remoteRepository: MoviesListRemoteRepositoryProtocol) {
        self.remoteRepository = remoteRepository
    }
    func getMovies() {
        remoteRepository.getMovies(completion: { result in
            switch result {
            case .success(let movies):
                print(movies.results?.first?.title)
            case .failure(let error):
                break
            }
        })
    }
}
