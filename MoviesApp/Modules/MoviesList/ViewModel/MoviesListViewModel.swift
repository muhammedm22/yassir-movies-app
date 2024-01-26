//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

/// Movies List sorting options
enum MovieListSortingOptions {
    case none
    case alphabet
    case votes
    case newest
}

/// MovieList ViewModel class which contain presentaion logic
final class MoviesListViewModel: ObservableObject {
    private var cancelable: Set<AnyCancellable> = []
    let useCase: MoviesListUseCaseProtocol
    var coordinator: MoviesListCoordinatorProtocol
    private var tempMovies: [Movie] = []
    @Published var movies: [Movie] = []
    @Published var screenTitle = "Movies List"
    @Published var showSortSheet = false
    @Published var isLoading = true
    init(useCase: MoviesListUseCaseProtocol, coordinator: MoviesListCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    /// Get List of movies
    func getMovies() {
        self.useCase.getMovies()
            .sink(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
            } , receiveValue: { [weak self] movies in
                guard let self else { return }
                self.movies = self.format(movies: movies)
                self.tempMovies = self.movies
            }).store(in: &cancelable)
    }
    
    /// Format list of movies
    /// - Parameter movies: [Movies]]
    /// - Returns: return list of movies formatted
    private func format(movies: [Movie]) -> [Movie] {
        return movies.map({
            let date = convertStringToDate(stringDate: $0.releaseYear)
            let yearFormmattedString = getStringFrom(date: date)
            return  Movie(
                id: $0.id,
                title: $0.title,
                desc: $0.desc,
                imageURL: $0.imageURL,
                releaseYear: yearFormmattedString,
                vote_average: $0.vote_average
            )
        })
    }
    
    /// Convert String To Date
    /// - Parameter stringDate: StringDate
    /// - Returns: Date
    private func convertStringToDate(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate) ?? Date()
    }
    
    /// Get String from Date
    /// - Parameter date: Date
    /// - Returns: Formatted Date string
    private func getStringFrom(date: Date) -> String {
        return  date.toString(format: "yyyy")
    }
    
    /// Sort Movies to any of sorting options
    /// - Parameter options: MovieListSortingOptions
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
    
    func search(text: String) {
        if text.isEmpty {
            movies = tempMovies
        } else  {
            movies = movies.filter({
                $0.title.lowercased().contains(text.trimmingCharacters(in: .whitespaces).lowercased())
            })
        }
    }
    func sortButtonTapped() {
        showSortSheet = true
    }
    func navigateToDetails(movie: Movie) -> MoviesDetailsView {
        return self.coordinator.initDetailsView(id: movie.id)
    }
}
