import UIKit
import Foundation

var greeting = "Latihan Berinteraksi dengan API Melalui HTTP GET"


let apiKey = "3e128906dc7b9f34448c28d8c2348c89"
let language = "en-US"
let page = "1"


var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
components.queryItems = [
    URLQueryItem(name: "api_key", value: apiKey),
    URLQueryItem(name: "language", value: language),
    URLQueryItem(name: "page", value: page),
]

let request = URLRequest(url: components.url!)

let task = URLSession.shared.dataTask(with: request) { data, res, error in
    guard let response = res as? HTTPURLResponse else {return}
    
    if let data = data {
        if response.statusCode == 200 {
            print("data \(data)")
            decodeJSON(from: data)
        }else {
            print("Error \(data), HTTPS status \(response.statusCode) ")
        }
    }
}

task.resume()



func decodeJSON(from data: Data) {
  let decoder = JSONDecoder()
 
  if let movies = try? decoder.decode(MovieResponses.self, from: data) as MovieResponses {
    print("PAGE: \(movies.page)")
    print("TOTAL RESULTS: \(movies.totalResults)")
    print("TOTAL PAGES: \(movies.totalPages)")
      
      print(movies.movies)
      
//      movies.movies.forEach { movie in
//           print("TITLE: \(movie.title)")
//           print("POSTER: \(movie.posterPath)")
//           print("DATE: \(movie.releaseDate)")
//         }
  } else {
    print("ERROR: Can't Decode JSON")
  }
}
 
struct MovieResponses: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let movies: [MovieResponse]
 
//  coding key for change key obj
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movies = "results"
  }
}

struct MovieResponse: Codable {
  let popularity: Double
  let posterPath: String
  let title: String
  let genres: [Int]
  let voteAverage: Double
  let overview: String
  let releaseDate: String
 
  enum CodingKeys: String, CodingKey {
    case popularity
    case posterPath = "poster_path"
    case title
    case genres = "genre_ids"
    case voteAverage = "vote_average"
    case overview
    case releaseDate = "release_date"
  }
}
