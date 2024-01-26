//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import UIKit

class MoviesListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
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
        setupSearchBar()
        showActivityIndicator()
        setupTableView()
        setNavigationController()
    }
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(MoviesTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(MoviesTableViewCell.self)")
    }
    private func setNavigationController() {
        title = "Movies List"
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortBtn))
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc func sortBtn() {
        showAlertSheet()
    }
    
    private func showAlertSheet() {
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .actionSheet)
        let newest = UIAlertAction(title: "Newest", style: .default) { [weak self] _ in
            self?.handleSortByNeswest()
        }
        alert.addAction(newest)
        let votes = UIAlertAction(title: "Votes", style: .default) { [weak self] _ in
            self?.handleSortByVotes()
        }
        alert.addAction(votes)
        let alpahbet = UIAlertAction(title: "Alphabetaclly", style: .default) { [weak self] _ in
            self?.handleSortByAlphabet()
        }
        alert.addAction(alpahbet)
        let cancelAction = UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            self?.handleResetSort()
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func handleSortByNeswest() {
        self.viewModel?.sort(options: .newest, completion: { [weak self] in
            self?.title = self?.viewModel?.soretedBy ?? ""
            self?.tableView.reloadData()
        })
    }
    private func handleSortByVotes() {
        self.viewModel?.sort(options: .votes, completion: { [weak self] in
            self?.title = self?.viewModel?.soretedBy ?? ""
            self?.tableView.reloadData()
        })
    }
    private func handleSortByAlphabet() {
        self.viewModel?.sort(options: .alphabet, completion: { [weak self] in
            self?.title = self?.viewModel?.soretedBy ?? ""
            self?.tableView.reloadData()
        })
    }
    private func handleResetSort() {
        self.viewModel?.sort(options: .none, completion: { [weak self] in
            self?.title = self?.viewModel?.soretedBy ?? ""
            self?.tableView.reloadData()
        })
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
extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(text: searchText, completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}
