//
//  MovieModel.swift
//  NetflixClone
//
//  Created by Bengi Anıl on 30.01.2024.
//

import Foundation

class MovieModel: ObservableObject {
    @Published var movie: Movie?

    init(movie: Movie? = nil) {
        self.movie = movie
    }
}

struct Movie: Codable {
    let dates: Dates?
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    let results: [Results]?
}

struct Dates: Codable {
    let maximum: String?
    let minimum: String?
}

struct Results: Codable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String
}

//let adult: Bool
//let backdropPath: String
//let genreIds: [Int]
//let id: Int
//let originalLanguage: String
//let originalTitle: String
//let overview: String
//let popularity: Double
//let posterPath: String
//let releaseDate: String
//let title: String
//let video: Bool
//let voteAverage: Double
//let voteCount: Int