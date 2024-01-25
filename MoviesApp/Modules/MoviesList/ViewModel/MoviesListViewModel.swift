//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

enum MovieListSortingOptions {
    case none
    case alphabet
    case votes
    case newest
}

final class MoviesListViewModel: ObservableObject {
    private var cancelable: Set<AnyCancellable> = []
    let useCase: MoviesListUseCaseProtocol
    var coordinator: MoviesListCoordinatorProtocol
    private var tempMovies: [Movie] = []
    @Published var movies: [Movie] = []
    @Published var screenTitle = "Movies List"
    @Published var showSortSheet = false
    init(useCase: MoviesListUseCaseProtocol, coordinator: MoviesListCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    func getMovies() {
        self.useCase.getMovies()
            .sink(receiveCompletion: { _ in } , receiveValue: { [weak self] movies in
                guard let self else { return }
                self.movies = self.format(movies: movies)
                self.tempMovies = self.movies
        }).store(in: &cancelable)
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
    
    func sort(options: MovieListSortingOptions) {
        switch options {
        case .alphabet:
            self.screenTitle = "Alpabet"
            self.movies = self.movies.sorted { $0.title < $1.title }
        case .newest:
            self.screenTitle = "Newest"
            self.movies = self.movies.sorted { $0.releaseYear > $1.releaseYear }
        case .votes:
            self.screenTitle = "Votes"
            self.movies = self.movies.sorted { $0.vote_average > $1.vote_average }
        case .none:
            self.screenTitle = "Movie List"
            self.movies = tempMovies
        }
    }
    func sortButtonTapped() {
        showSortSheet = true
    }
}
