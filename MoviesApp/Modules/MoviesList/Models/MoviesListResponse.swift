//
//  MoviesListResponse.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

// MARK: - MoviesListResponse
struct MoviesListResponse: Codable {
    let page: Int?
    let results: [MoviesListResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MoviesListResult: Codable {
    let id: Int?
    let posterPath, title: String?
    let overview: String?
    let release_date: String?
    let vote_average: Float?
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case overview
        case release_date
        case vote_average
    }
}
