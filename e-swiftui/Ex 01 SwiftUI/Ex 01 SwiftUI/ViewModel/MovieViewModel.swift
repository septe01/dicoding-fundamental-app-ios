//
//  MovieViewModel.swift
//  Ex 01 SwiftUI
//
//  Created by septe habudin on 21/10/22.
//

import Foundation

class MovieViewModel {
// MARK: Gunakan API Key dalam akun Anda.
let apiKey = "3e128906dc7b9f34448c28d8c2348c89"
let language = "en-US"
let page = "1"

func getMovies() async throws -> [Movie] {
  var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
  components.queryItems = [
    URLQueryItem(name: "api_key", value: apiKey),
    URLQueryItem(name: "language", value: language),
    URLQueryItem(name: "page", value: page)
  ]
  let request = URLRequest(url: components.url!)

  let (data, response) = try await URLSession.shared.data(for: request)

  guard (response as? HTTPURLResponse)?.statusCode == 200 else {
    fatalError("Error: Can't fetching data.")
  }

  let decoder = JSONDecoder()
  let result = try decoder.decode(MovieResponses.self, from: data)

  return movieMapper(input: result.movies)
}
}

extension MovieViewModel {
fileprivate func movieMapper(
  input movieResponses: [MovieResponse]
) -> [Movie] {
  return movieResponses.map { result in
    return Movie(
      idMovie: result.idMovie,
      title: result.title,
      overview: result.overview,
      posterPath: result.posterPath
    )
  }
}
}
