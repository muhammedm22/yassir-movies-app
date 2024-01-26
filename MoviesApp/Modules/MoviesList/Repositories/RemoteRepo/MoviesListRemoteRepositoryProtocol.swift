//
//  MoviesListRemoteRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
/// Movies List Remote reposiitory protcool
protocol MoviesListRemoteRepositoryProtocol: AnyObject {
    func getMovies(completion: @escaping (Swift.Result<MoviesListResponse, NetworkError>) -> Void)
}
