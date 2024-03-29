//
//  MovieViewModel.swift
//  NetflixClone
//
//  Created by Bengi Anıl on 27.02.2024.
//

import Foundation

class MovieViewModel: ObservableObject {
    private var manager = NetworkManager()
    @Published var movieModel: Movie?
    @Published var filteredMovieModel: Movie?
    @Published var genreModel: Genres?
    @Published var detailModel: MovieDetails?
    @Published var genreNames: [String]?

    func fetchMovieData(index: Int) async {
        do {
            let path = SliderCode(rawValue: index)?.path
            let movie = try await manager.fetchData(for: Movie.self, from: path ?? "")
            let genres = try await manager.fetchData(for: Genres.self, from: "/genre/movie/list")
            
            DispatchQueue.main.async {
                self.movieModel = movie
                self.genreModel = genres
            }
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func fetchMoviesByTitle(text: String) async {
        do {
            let path = "/search/movie?query=\(text)"
            let movie = try await manager.fetchData(for: Movie.self, from: path)

            DispatchQueue.main.async {
                self.filteredMovieModel = movie
            }
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func fetchMovieDetails(item: Results) async {
        do {
            let path = "/movie/\(item.id)"
            let detailModel = try await manager.fetchData(for: MovieDetails.self, from: path)
            let genres = try await manager.fetchData(for: Genres.self, from: "/genre/movie/list")

            DispatchQueue.main.async {
                self.detailModel = detailModel
                self.genreModel = genres
            }
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func getGenresName(item: Results, genres: Genres) async {
        let genreNames = item.genreIds.compactMap { genreId in
            return genres.genres.first(where: { $0.id == genreId })?.name
        }
        DispatchQueue.main.async {
            self.genreNames = genreNames
        }
    }
}
