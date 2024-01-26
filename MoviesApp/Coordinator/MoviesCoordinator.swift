//
//  MoviesListCoordinator.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit
import SwiftUI
protocol MoviesListCoordinatorProtocol: AnyObject {
    func initDetailsView(id: Int) -> MoviesDetailsView
}
class MoviesListCoordinator: Coordinator, MoviesListCoordinatorProtocol {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let movieListView = MoviesListConfigurator.configureModule(coordinator: self)
        let moviesListVC = UIHostingController(rootView: movieListView)
        navigationController.pushViewController(moviesListVC, animated: false)
    }
    func initDetailsView(id: Int) -> MoviesDetailsView {
        return MovieDetailsConfigurator.configureModule(id: id)
    }
}
