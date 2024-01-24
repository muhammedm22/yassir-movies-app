//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol MoviesListViewModelProtocol: AnyObject {
    var movies: [Movie] { get set }
    func getMovies(completion: @escaping () -> Void)
    func didTapMovie(index: Int)
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    let useCase: MoviesListUseCaseProtocol
    var movies: [Movie] = []
    var coordinator: MoviesListCoordinatorProtocol
    init(useCase: MoviesListUseCaseProtocol, coordinator: MoviesListCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    func getMovies(completion: @escaping () -> Void) {
        self.useCase.getMovies(completion: { [weak self] movies in
            guard let self else { return }
            self.movies = format(movies: movies)
            completion()
        })
    }
    
    private func format(movies: [Movie]) -> [Movie] {
        return movies.map({
            let date = convertStringToDate(stringDate: $0.releaseYear)
            let yearFormmattedString = getStringFrom(date: date)
           return  Movie(id: $0.id, title: $0.title, desc: $0.desc, imageURL: $0.imageURL, releaseYear: yearFormmattedString) })
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
}
