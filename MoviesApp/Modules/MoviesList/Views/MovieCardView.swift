//
//  MovieCardView.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 25/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {
    var movie: Movie
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            WebImage(url: movie.imageURL)
                .resizable()
                .frame(width: 92, height: 92)
            VStack(alignment: .leading, spacing: 12) {
                Text(movie.title)
                    .multilineTextAlignment(.leading)
                Text(movie.releaseYear)
                    .multilineTextAlignment(.leading)
            }
               Spacer()
        }.frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie(id: 1, title: "Title", desc: "Desc", imageURL: URL(string: "www.google.com") ?? URL(fileURLWithPath: ""), releaseYear: "", vote_average: 0.0) )
    }
}
