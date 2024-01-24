//
//  Movie.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
// DTO 
struct Movie {
    let id: Int
    let title: String
    let desc: String
    let imageURL: URL
    var releaseYear: String
    let vote_average: Float
}
