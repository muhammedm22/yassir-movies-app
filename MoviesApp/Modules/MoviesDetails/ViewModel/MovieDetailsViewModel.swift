//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    var movie: Movie? { get set }
    func getDetails(completion: @escaping () -> Void)
}
final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var movie: Movie?
    private var id: Int
    private let useCase: MovieDetailsUseCaseProtocol
    
    /// init
    /// - Parameters:
    ///   - id: Movie id
    ///   - useCase: Movie Details useCase
    init(id: Int, useCase: MovieDetailsUseCaseProtocol) {
        self.id = id
        self.useCase = useCase
    }
    /// GetDetails Data
    /// - Parameter Completion handler
    func getDetails(completion: @escaping () -> Void) {
        useCase.getMovie(id: id, completion: { [weak self] movie in
            self?.movie = movie
            completion()
        })
    }
}
