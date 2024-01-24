//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    var movie: Movie { get set}
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var movie: Movie
    init(movie: Movie) {
        self.movie = movie
        setYear()
    }
    
    private func convertStringToDate(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate) ?? Date()
    }
    
    private func setYear() {
        let date = convertStringToDate(stringDate: movie.releaseYear)
        self.movie.releaseYear = date.toString(format: "yyyy")
    }
}
