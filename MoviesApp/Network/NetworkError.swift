//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

/// Network Request Errors
enum NetworkError: Error {
    case normalError(Error)
    case badURL
}
