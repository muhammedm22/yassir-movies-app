//
//  MoviesListConfigurator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation

final class MoviesListConfigurator {
    static func configureModule(coordinator: MoviesListCoordinatorProtocol) -> MoviesListViewController {
        let remoteRepo = MoviesListRemoteRepository()
        let useCase = MoviesListUseCase(remoteRepository: remoteRepo)
        let viewModel = MoviesListViewModel(useCase: useCase, coordinator: coordinator)
        return MoviesListViewController(viewModel: viewModel)
    }
}
