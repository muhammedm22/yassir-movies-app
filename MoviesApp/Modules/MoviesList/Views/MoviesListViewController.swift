//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit

class MoviesListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties
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
        setUI()
        viewModel?.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideActivityIndicator()
            }
        }
    }
    private func setUI() {
        showActivityIndicator()
        setupTableView()
        setNavigationController()
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(MoviesTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(MoviesTableViewCell.self)")
    }
    private func setNavigationController() {
        title = "Movies List"
    }
}
// MARK: - UITableView Protocols extension
extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel?.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MoviesTableViewCell.self)") as? MoviesTableViewCell
        if let movie = movie{
            cell?.configureCell(movie: movie)
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didTapMovie(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MoviesListViewController {
    func showActivityIndicator() {
        activityIndicator.isHidden = false
    }
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
    }
}
