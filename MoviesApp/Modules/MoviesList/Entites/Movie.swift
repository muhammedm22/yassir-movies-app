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
    init(
        id: Int = 0,
        title: String = "",
        desc: String = "",
        imageURL: URL = URL(fileURLWithPath: ""),
        releaseYear: String = "",
        vote_average: Float = 0.0) {
        self.id = id
        self.title = title
        self.desc = desc
        self.imageURL = imageURL
        self.releaseYear = releaseYear
        self.vote_average = vote_average
    }
}
