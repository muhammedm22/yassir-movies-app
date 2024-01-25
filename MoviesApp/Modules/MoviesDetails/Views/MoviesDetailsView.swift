//
//  MoviesDetails.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 25/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviesDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    init(viewModel: MovieDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack {
                WebImage(url: viewModel.movie.imageURL)
                    .resizable()
                    .frame(height: 300)
                Text(viewModel.movie.title)
                Text(viewModel.movie.desc)
            }.task {
                viewModel.getDetails()
            }
        }
    }
}
