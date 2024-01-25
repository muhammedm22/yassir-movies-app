//
//  MovieDetailsResponseModel.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

/// Movies Details Response model
struct MovieDetailsResponse: Codable {
    let id: Int?
    let overview: String?
    let releaseDate: String?
    let title: String?
    let posterPath: String?
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
