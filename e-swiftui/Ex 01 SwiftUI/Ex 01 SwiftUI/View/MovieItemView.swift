//
//  MovieItemView.swift
//  Ex 01 SwiftUI
//
//  Created by septe habudin on 21/10/22.
//

import SwiftUI

struct MovieItemView: View {
    var movie: Movie
      var body: some View {
        HStack {
          AsyncImage(url: movie.posterPath) { image in
            image.resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
              ProgressView()
          }.frame(width: 80, height: 80)

          Text(movie.title)
            .font(.system(size: 20))
        }.padding([.top, .leading, .trailing])
      }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(movie: movies[0])
    }
}
