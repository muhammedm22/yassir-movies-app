//
//  MovieDetailsUseCaseProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
/// MovieDetailsUseCaseProtocol
protocol MovieDetailsUseCaseProtocol: AnyObject {
    func getMovie(id: Int, completion: @escaping (Movie) -> Void)
}
