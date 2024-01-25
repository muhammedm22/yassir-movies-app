//
//  MovieDetailsConfigurator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 25/01/2024.
//

import SwiftUI
final class MovieDetailsConfigurator {
    static func configureModule(id: Int) -> MoviesDetailsView {
        let remoteRepo = MoviesDetailsRemoteRepository()
        let useCase = MovieDetailsUseCase(remoteRepository: remoteRepo)
        let viewModel = MovieDetailsViewModel(id: id, useCase: useCase)
        let detailsVC = MoviesDetailsView(viewModel: viewModel)
        return detailsVC
    }
}
