//
//  MoviesListConfigurator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import SwiftUI

/// MovieDetailsConfigurator
final class MoviesListConfigurator {
    /// Factory method to set depedencies
    /// - Parameter id: Movie Id
    /// - Returns: MovieDetailsView
    static func configureModule(coordinator: MoviesListCoordinatorProtocol) -> MoviesListView {
        let remoteRepo = MoviesListRemoteRepository()
        let useCase = MoviesListUseCase(remoteRepository: remoteRepo)
        let viewModel = MoviesListViewModel(useCase: useCase, coordinator: coordinator)
        return MoviesListView(viewModel: viewModel)
    }
}
