//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol MoviesListViewModelProtocol: AnyObject {
    var movies: [Movie] { get set }
    func getMovies(completion: @escaping () -> Void)
    func didTapMovie(index: Int)
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    let useCase: MoviesListUseCaseProtocol
    var movies: [Movie] = []
    var coordinator: MoviesListCoordinatorProtocol
    init(useCase: MoviesListUseCaseProtocol, coordinator: MoviesListCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    func getMovies(completion: @escaping () -> Void) {
        self.useCase.getMovies(completion: { [weak self] movies in
            guard let self else { return }
            self.movies = movies
            completion()
        })
    }
    func didTapMovie(index: Int) {
        let movie = movies[index]
        self.coordinator.navigateToDetails(movie: movie)
    }
}
