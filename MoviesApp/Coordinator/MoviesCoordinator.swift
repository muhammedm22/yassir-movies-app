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
        let moviesListVC = MoviesListConfigurator.configureModule(coordinator: self)
        navigationController.pushViewController(moviesListVC, animated: false)
    }
    func navigateToDetails(movie: Movie) {
        let detailsVC = MoviesDetailsConfigurator.configureModule(id: movie.id)
        self.navigationController.pushViewController(detailsVC, animated: true)
    }
}
