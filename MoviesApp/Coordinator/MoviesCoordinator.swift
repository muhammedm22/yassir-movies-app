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
        let remoteRepo = MoviesListRemoteRepository()
        let useCase = MoviesListUseCase(remoteRepository: remoteRepo)
        let viewModel = MoviesListViewModel(useCase: useCase, coordinator: self)
        let moviesListVC = UIHostingController(rootView: MoviesListView(viewModel: viewModel))
        navigationController.pushViewController(moviesListVC, animated: false)
    }
    
    func initDetailsView(id: Int) -> MoviesDetailsView {
        return MovieDetailsConfigurator.configureModule(id: id)
    }
}
