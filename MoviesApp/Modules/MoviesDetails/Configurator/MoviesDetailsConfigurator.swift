//
//  MoviesDetailsConfigurator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation

final class MoviesDetailsConfigurator {
    static func configureModule(id: Int) -> MovieDetailsViewController {
        let remoteRepo = MoviesDetailsRemoteRepository()
        let useCase = MovieDetailsUseCase(remoteRepository: remoteRepo)
        let viewModel = MovieDetailsViewModel(id: id, useCase: useCase)
        let detailsVC = MovieDetailsViewController(viewModel: viewModel)
        return detailsVC
    }
}
