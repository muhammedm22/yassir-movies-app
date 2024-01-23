//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol MoviesListViewModelProtocol: AnyObject {
    func getMovies()
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    let useCase: MoviesListUseCaseProtocol
    init(useCase: MoviesListUseCaseProtocol) {
        self.useCase = useCase
    }
    func getMovies() {
        self.useCase.getMovies()
    }
}
