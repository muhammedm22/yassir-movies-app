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
    
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    let useCase: MoviesListUseCaseProtocol
    var movies: [Movie] = []
    init(useCase: MoviesListUseCaseProtocol) {
        self.useCase = useCase
    }
    func getMovies(completion: @escaping () -> Void) {
        self.useCase.getMovies(completion: { [weak self] movies in
            guard let self else { return }
            self.movies = movies
            completion()
        })
    }
}
