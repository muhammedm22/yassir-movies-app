//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

enum NetworkError: Error {
    case normalError(Error)
    case badURL
}
