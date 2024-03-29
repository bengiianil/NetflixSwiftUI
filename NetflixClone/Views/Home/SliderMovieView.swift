//
//  SliderMovieView.swift
//  NetflixClone
//
//  Created by Bengi Anıl on 16.02.2024.
//

import SwiftUI

struct SliderMovieView: View {
    @ObservedObject private var viewModel = MovieViewModel()
    @State var index: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                let title = SliderCode(rawValue: index)?.title
                Text(title ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.movieModel?.results?.reversed() ?? [], id: \.id) { item in
                        if let genres = viewModel.genreModel {
                            let url = Constants.imageUrl + (item.posterPath)
                            NavigationLink(destination: MovieDetailView(item: item, genres: genres)) {
                                MovieView(url: url)
                                    .padding(.horizontal, 4)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .task {
            await viewModel.fetchMovieData(index: index)
        }
    }
}

#Preview {
    SliderMovieView(index: 0)
}
