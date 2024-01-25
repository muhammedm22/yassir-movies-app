//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie = Movie()
    private var id: Int
    private let useCase: MovieDetailsUseCaseProtocol
    private var cancelable: Set<AnyCancellable> = []
    
    init(id: Int, useCase: MovieDetailsUseCaseProtocol) {
        self.id = id
        self.useCase = useCase
    }
    func getDetails() {
        useCase.getMovie(id: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movie in
                guard let self else { return }
                self.movie = movie
            }).store(in: &cancelable)
    }
}
