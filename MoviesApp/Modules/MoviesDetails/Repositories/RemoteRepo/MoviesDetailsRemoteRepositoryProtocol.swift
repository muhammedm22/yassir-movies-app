//
//  MoviesDetailsRemoteRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 26/01/2024.
//

import Foundation
/// MoviesDetailsRemoteRepositoryProtocol
protocol MoviesDetailsRemoteRepositoryProtocol: AnyObject {
    func getMovie(data: MovieDetailsRequestModel, completion: @escaping (Swift.Result<MovieDetailsResponse, NetworkError>) -> Void)
}
