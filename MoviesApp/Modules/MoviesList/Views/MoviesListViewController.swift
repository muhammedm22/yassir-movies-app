//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit

class MoviesListViewController: UIViewController {
    private var viewModel: MoviesListViewModelProtocol?
    init(viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getMovies()
    }
}
