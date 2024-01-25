//
//  MoviesList.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 25/01/2024.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel: MoviesListViewModel
    init(viewModel: MoviesListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.movies, id:\.id) { movie in
                        NavigationLink(destination: MovieDetailsConfigurator.configureModule(id: movie.id), label: {
                            MovieCardView(movie: movie)
                                .foregroundColor(Color.black)
                        })
                    }
                }.frame(maxWidth: .infinity)
                    .task {
                        viewModel.getMovies()
                    }
            }
            .navigationTitle(viewModel.screenTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sort") {
                        viewModel.sortButtonTapped()
                    }        .actionSheet(isPresented: $viewModel.showSortSheet) {
                        ActionSheet(
                            title: Text("Sort"),
                            buttons: [
                                .default(Text("Newest")) {
                                    viewModel.sort(options: .newest)
                                },
                                .default(Text("Alphabet")) {
                                    viewModel.sort(options: .alphabet)
                                },
                                .default(Text("Votes")) {
                                    viewModel.sort(options: .votes)
                                },
                                .destructive(Text("Cancel")) {
                                    viewModel.sort(options: .none)
                                }
                            ]
                        )
                    }
                }
            }
    }
}
