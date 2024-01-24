//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

enum MovieListSortingOptions {
    case none
    case alphabet
    case votes
    case newest
}

protocol MoviesListViewModelProtocol: AnyObject {
    var movies: [Movie] { get set }
    var soretedBy: String? { get set }
    func getMovies(completion: @escaping () -> Void)
    func didTapMovie(index: Int)
    func sort(options: MovieListSortingOptions, completion: @escaping () -> Void)
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    
    let useCase: MoviesListUseCaseProtocol
    var movies: [Movie] = []
    var soretedBy: String?
    var coordinator: MoviesListCoordinatorProtocol
    private var tempMovies: [Movie] = []
    
    init(useCase: MoviesListUseCaseProtocol, coordinator: MoviesListCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    func getMovies(completion: @escaping () -> Void) {
        self.useCase.getMovies(completion: { [weak self] movies in
            guard let self else { return }
            self.movies = format(movies: movies)
            self.tempMovies = self.movies
            completion()
        })
    }
    
    private func format(movies: [Movie]) -> [Movie] {
        return movies.map({
            let date = convertStringToDate(stringDate: $0.releaseYear)
            let yearFormmattedString = getStringFrom(date: date)
            return  Movie(id: $0.id, title: $0.title, desc: $0.desc, imageURL: $0.imageURL, releaseYear: yearFormmattedString, vote_average: $0.vote_average) })
    }
    private func convertStringToDate(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate) ?? Date()
    }
    
    private func getStringFrom(date: Date) -> String {
        return  date.toString(format: "yyyy")
    }
    func didTapMovie(index: Int) {
        let movie = movies[index]
        self.coordinator.navigateToDetails(movie: movie)
    }
    
    func sort(options: MovieListSortingOptions, completion: @escaping () -> Void) {
        switch options {
        case .alphabet:
            self.soretedBy = "Alpabet"
            self.movies = self.movies.sorted { $0.title < $1.title }
        case .newest:
            self.soretedBy = "Newest"
            self.movies = self.movies.sorted { $0.releaseYear > $1.releaseYear }
        case .votes:
            self.soretedBy = "Votes"
            self.movies = self.movies.sorted { $0.vote_average > $1.vote_average }
        case .none:
            self.soretedBy = "Movie List"
            self.movies = tempMovies
        }
        completion()
    }
}
