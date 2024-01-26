//
//  MoviesListUseCaseProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
/// MoviesList Usecase Protcool
protocol MoviesListUseCaseProtocol: AnyObject {
    func getMovies(completion: @escaping ([Movie]) -> Void)
}
