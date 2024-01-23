//
//  MoviesListCoordinator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit

class MoviesListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let remoteRepo = MoviesListRemoteRepository()
        let useCase = MoviesListUseCase(remoteRepository: remoteRepo)
        let viewModel = MoviesListViewModel(useCase: useCase)
        let moviesListVC = MoviesListViewController(viewModel: viewModel)
        navigationController.pushViewController(moviesListVC, animated: false)
    }
    
}
