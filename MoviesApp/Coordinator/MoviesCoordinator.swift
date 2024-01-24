//
//  MoviesListCoordinator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit
protocol MoviesListCoordinatorProtocol: AnyObject {
    func navigateToDetails(movie: Movie)
}
class MoviesListCoordinator: Coordinator, MoviesListCoordinatorProtocol {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let remoteRepo = MoviesListRemoteRepository()
        let useCase = MoviesListUseCase(remoteRepository: remoteRepo)
        let viewModel = MoviesListViewModel(useCase: useCase, coordinator: self)
        let moviesListVC = MoviesListViewController(viewModel: viewModel)
        navigationController.pushViewController(moviesListVC, animated: false)
    }
    func navigateToDetails(movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let detailsVC = MovieDetailsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(detailsVC, animated: true)
    }
    
}
